GNUPlotr: an easy interface between Ruby and GNUPlot
====================================================

Introduction
------------

Here's a quick example:
	
	require "gnuplotr"
	
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

	# command history can be dumped and possibly saved on file to be edited or loaded again later on.
	puts gp.dump_input
	
Installation
------------

As usual, use the gem:

	% [sudo] gem install gnuplotr

Needless to say, you probably have to install a GNUPlot version in order to use gnuplotr...