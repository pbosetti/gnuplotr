##!/usr/bin/env ruby
# test.rb

# Created by Paolo Bosetti on 2011-02-22.
# Copyright (c) 2011 University of Trento. All rights reserved.

require './lib/gnuplotr'

# Instantiate
gp = GNUPlotr.new

# Create and fill a new series with pairs. This creates the parabola.dat file
# Block-based way to do it:
gp.fill_series(:parabola) do |series|
  (0..99).each do |i|
    series << [i, i**2]
  end
end

# conventional way:
gp.new_series(:parabola_2)
(0..99).each do |i|
  gp.series[:parabola_2] << [i, i**2]
end
gp.series[:parabola_2].close  # Remember to call this!


# enable command history recording
gp.record = true

# Issue raw gnuplot commands
gp.raw "set grid"

# Some magic mapping works too:
gp.set_grid
gp.set_title 'GNUPlotr example'
gp.set_xlabel 'x', :offset => 3, :font => "Times New Roman,26"
gp.set_ylabel "f(x)"

# issue plotting commands, either with named data series
gp.plot :parabola, "using 1:2 with points axes x1y1"

# or with formulas. Options are collected in a string passed as second optional argument
gp.replot "x**2", "with lines"


# command history can be dumper and possibly saved on file to be edited or loaded again later on.
puts gp.dump_input