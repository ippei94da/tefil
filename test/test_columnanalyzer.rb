#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"
require "stringio"

class Tefil::ColumnAnalyzer
  public :process_stream, :projection_ary
end

class TC_ColumnAnalyzer < Test::Unit::TestCase

  TEXT = [
    '0123 45 6789',
    'abcd ef ghij',
    'a    e  g   ',
    'a cd  f gh j',
    'abcd        ',
    '         hij',
  ]

  def setup
    @c00 = Tefil::ColumnAnalyzer.new
  end

  def test_projection_ary
    results = @c00.projection_ary(TEXT)
    corrects = [true, true, true, true, false,
                true, true, false,
                true, true, true, true]
    assert_equal(corrects, results)
  end

  def test_process_stream
    in_io = StringIO.new
    in_io.puts '0123 45 6789'
    in_io.puts 'abcd ef ghij'
    in_io.puts 'a    e  g   '
    in_io.puts 'a cd  f gh j'
    in_io.puts 'abcd        '
    in_io.puts '         hij'
    in_io.rewind
    out_io = StringIO.new
    @c00.process_stream(in_io, out_io)
    #assert_equal
  end
end

