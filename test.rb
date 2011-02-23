##!/usr/bin/env ruby
# test.rb

# Created by Paolo Bosetti on 2011-02-22.
# Copyright (c) 2011 University of Trento. All rights reserved.

require './lib/gnuplotr'

# Instantiate
gp = GNUPlotr.new

# add an empty data series
gp.new_series :parabola

# fill the series with pairs. This creates the parabola.dat file
gp.fill_series(:parabola) do |series|
  (0..99).each do |i|
    series << [i, i**2]
  end
end

# enable command history recording
gp.record = true

# issue plotting commands, either with named data series
gp.plot :parabola, "using 1:2 with points"

# or with formulas. Options are collected in a string passed as second optional argument
gp.replot "x**2", "with lines"

# command history can be dumper and possibly saved on file to be edited or loaded again later on.
puts gp.dump_input