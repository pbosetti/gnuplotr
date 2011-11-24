# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gnuplotr}
  s.version = "0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paolo Bosetti"]
  s.date = %q{2011-03-05}
  s.description = %q{Interface between Ruby and GNUPlot}
  s.email = %q{paolo.bosetti@me.com}
  s.files = %w[README.markdown lib/gnuplotr.rb test_unix.rb test_windows.rb test_unix_animation.rb]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pbosetti/gnuplotr}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{gnuplotr}
  s.rubygems_version = %q{1.2.0}
  s.has_rdoc = true
  s.summary = %q{Interface between Ruby and GNUPlot, aimed at being as easy to use and as light as possible}

end