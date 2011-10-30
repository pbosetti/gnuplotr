##!/usr/bin/env ruby
# test.rb

# Created by Paolo Bosetti on 2011-02-22.
# Edited by Carlos Maximiliano Giorgio Bort on 2012-03-05.
# Copyright (c) 2011 University of Trento. All rights reserved.

require './lib/gnuplotr'

XMAX = 99

# Instantiate
gp = GNUPlotr.new
# enable command history recording
gp.record = true
# Issue raw gnuplot commands
gp.raw "set grid"
# Some magic mapping works too:
gp.set_grid
gp.set_title 'GNUPlotr example'
gp.set_xlabel 'x', :offset => 3, :font => "Times New Roman,26"
gp.set_ylabel "f(x)"
j = 1
while j <= XMAX
    sleep(0.1)
    # Create and fill a new series with pairs. This creates the parabola_2.dat file
    gp.new_series(:parabola)
    (0..j).each do |i|
    gp.series[:parabola] << [i, i**2]
    end
    gp.series[:parabola].close  # Remember to call this!
    
    gp.new_series(:iperbole)
    (0..j).each do |i|
    gp.series[:iperbole] << [i, 10000/(i+1)]
end
    gp.series[:iperbole].close  # Remember to call this!
    # issue plotting commands, either with named data series
    
    gp.plot :parabola, "using 1:2 with points axes x1y1; set xrange [0:#{XMAX}]"
    gp.replot :iperbole, "with lines"
    # or with formulas. Options are collected in a string passed as second optional argument
    gp.replot "x**2", "with lines" # this plots a green parabola f(x) = x^2
    j += 1
end
# command history can be dumper and possibly saved on file to be edited or loaded again later on.
puts gp.dump_input