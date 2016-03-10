# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: tefil 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "tefil"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["ippei94da"]
  s.date = "2016-03-10"
  s.description = "This gem provides a framework of text filter.\n    Tefil eneable to make text filter commands which have overwrite option easily.\n  "
  s.email = "ippei94da@gmail.com"
  s.executables = ["columnform", "eachsentence", "fswiki2md", "indentconv", "indentstat", "linesub", "md2fswiki", "percentpack", "zshescape"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "CHANGES",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/columnform",
    "bin/eachsentence",
    "bin/fswiki2md",
    "bin/indentconv",
    "bin/indentstat",
    "bin/linesub",
    "bin/md2fswiki",
    "bin/percentpack",
    "bin/zshescape",
    "doc/memo.txt",
    "example/columnformer/sample.txt",
    "example/eachsentence/sample.txt",
    "example/indentconv/sample0.txt",
    "example/indentconv/sample1.txt",
    "example/indentstat/indent4.txt",
    "example/indentstat/sample0.txt",
    "example/indentstat/sample1.txt",
    "example/percentpack/sample.txt",
    "example/zshescape/sample.txt",
    "lib/tefil.rb",
    "lib/tefil/columnformer.rb",
    "lib/tefil/eachsentence.rb",
    "lib/tefil/fswikitomd.rb",
    "lib/tefil/indentconverter.rb",
    "lib/tefil/indentstatistics.rb",
    "lib/tefil/linesubstituter.rb",
    "lib/tefil/mdtofswiki.rb",
    "lib/tefil/percentpacker.rb",
    "lib/tefil/textfilterbase.rb",
    "lib/tefil/zshescaper.rb",
    "tefil.gemspec",
    "test/formcolumn_space",
    "test/helper.rb",
    "test/test_columnformer.rb",
    "test/test_eachsentence.rb",
    "test/test_fswikitomd.rb",
    "test/test_indentconverter.rb",
    "test/test_indentstatistics.rb",
    "test/test_linesubstituter.rb",
    "test/test_mdtofswiki.rb",
    "test/test_percentpacker.rb",
    "test/test_textfilterbase.rb",
    "test/test_zshescaper.rb"
  ]
  s.homepage = "http://github.com/ippei94da/tefil"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Basic framework of text filter"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit>, ["~> 3.1"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.11"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.11"])
      s.add_development_dependency(%q<capture_stdout>, ["~> 0.0"])
      s.add_development_dependency(%q<builtinextension>, ["~> 0.1"])
    else
      s.add_dependency(%q<test-unit>, ["~> 3.1"])
      s.add_dependency(%q<rdoc>, ["~> 4.2"])
      s.add_dependency(%q<bundler>, ["~> 1.11"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.11"])
      s.add_dependency(%q<capture_stdout>, ["~> 0.0"])
      s.add_dependency(%q<builtinextension>, ["~> 0.1"])
    end
  else
    s.add_dependency(%q<test-unit>, ["~> 3.1"])
    s.add_dependency(%q<rdoc>, ["~> 4.2"])
    s.add_dependency(%q<bundler>, ["~> 1.11"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.11"])
    s.add_dependency(%q<capture_stdout>, ["~> 0.0"])
    s.add_dependency(%q<builtinextension>, ["~> 0.1"])
  end
end

