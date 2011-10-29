GNUPlotr: an easy interface between Ruby and GNUPlot
====================================================

Introduction
------------

Here's a quick example:
	
	require "gnuplotr"
	
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
        gp.set_xrange [0:50]
  
	# issue plotting commands, either with named data series
	gp.plot :parabola, "using 1:2 with points axes x1y1"

	# or with formulas. Options are collected in a string passed as second optional argument
	gp.replot "x**2", "with lines"


	# command history can be dumper and possibly saved on file to be edited or loaded again later on.
	puts gp.dump_input
	
Installation
------------

As usual, use the gem:

	% [sudo] gem install gnuplotr

Needless to say, you probably have to install a GNUPlot version in order to use gnuplotr. At the moment, gnuplotr is not too smart in detecting your GNUPlot installation path: it simply assumes that you are on MAC OS X and that you installed it via port, so that the executable is on /opt/local/bin/gnuplot.

If that is not your case, you must specify GNUPlot path as argument when you instantiate gnuplotr:

	gp = GNUPlotr.new("/path/to/your/gnuplot")
	
**Please Note**: on Mac OS X, it seems that GNUPlot fails plotting on AquaTerm the first time you use it. To overcome this problem, do like that:

1. launch GNUPlot in Terminal and type some plotting command (*e.g.* plot sin(x)). Most probably nothing will happen.
2. Manually launch AquaTerm (it is in Applications)
3. Exit GNUPlot and launch it again, then try again to plot. Now it should work fine.
4. From now on, gnuplotr should work fine too, and you even don't need to pre-launch AquaTerm (it will open automatically).