#!/usr/bin/env ruby
# gnuplotr.rb

# Created by Paolo Bosetti on 2011-02-23.
# Copyright (c) 2011 University of Trento. All rights reserved.

require "open3"

class DataSeries
  def initialize(name)
    raise ArgumentError, "name must be a Symbol" unless name.kind_of? Symbol
    @name = name
    @width = nil
    @length = 0
    @handle = File.open("#{@name.to_s}.dat", "w")
    @handle.puts "\# #{@name} datafile generated on #{Time.now} by GNUPlotr"
  end
  
  def <<(ary)
    @width = ary.size unless @width
    raise ArgumentError, "record size mismatch (not #{@width})" unless ary.size == @width
    @handle.puts(ary * "\t")
    @length += 1
  end
  
  def close
    @handle.close
  end
  
end

class GNUPlotr
  attr_accessor :gnuplot_path, :series, :record
  def initialize(path=nil)
    @gnuplot_path = (path || find_path)
    raise RuntimeError, "Could not find #{@gnuplot_path}" unless File.exist? @gnuplot_path
    @gnuplot, @stdout, @stderr = Open3.popen3(@gnuplot_path)
    Thread.new { capture(@stdout) {|line| puts "> " + line } } 
    Thread.new { capture(@stderr) {|line| warn ">>" + line } } 
    @series = {}
    @record = false
    @record_list = []
  end
  
  def new_series(name)
    raise ArgumentError, "name must be a Symbol" unless name.kind_of? Symbol
    @series[name] = DataSeries.new(name)
  end
  
  def fill_series(name)
    raise "Need a block" unless block_given?
    new_series(name) unless @series[name]
    yield @series[name]
    @series[name].close
  end
  
  def method_missing(name, *args, &block)
    options = args.inject("") {|s, t|
      s + " " + parse_tokens(t)
    }
    raw "#{name.to_s.sub(/_/, " ")} #{options}"
  end
    
  def raw(message)
    @record_list << message if @record
    @gnuplot.puts message
  end

  def plot(arg, opts=nil)
    _plot("plot", arg, opts)
  end
  
  def replot(arg, opts=nil)
    _plot("replot", arg, opts)  
  end
  
  def dump_input
    header = "\# Gnuplot inputfile generated on #{Time.now} by GNUPlotr\n"
    header + @record_list * "\n"
  end
  
  def reset
    @record_list = []
  end
  
  private
  def _plot(cmd, arg, opts=nil)
    case arg
    when String
      raw "#{cmd} #{arg} #{opts}"
    when Symbol
      raw "#{cmd} '#{arg.to_s}.dat' #{opts}"
    else
      raise ArgumentError
    end
  end
  
  def capture(handle, &block)
    loop do
      line = handle.gets.chomp
      yield line if line =~ /^\s*\w+/ 
    end
  end
  
  def parse_tokens(t)
    case t
    when Symbol
      t.to_s
    when String
      "'#{t}'"
    when Range
      "[#{t.begin}:#{t.end}]"
    when Hash
      r = ""
      t.each {|k,v|
        r += " #{k.to_s} #{parse_tokens(v)}"
      }
      r
    else
      t.to_s
    end
  end
  
  def find_path
    `which gnuplot`.chomp
  end
end



if $0 == __FILE__
  gp = GNUPlotr.new
  gp.fill_series(:parabola) do |s|
    (0..99).each do |i|
      s << [i, i**2]
    end
  end
  gp.record = true
  gp.plot :parabola, "using 1:2"
  gp.replot "x**2", "with linespoints"
  gp.raw "show term"
  gp.raw "quit()"
  sleep 0.1 
  puts gp.dump_input
end