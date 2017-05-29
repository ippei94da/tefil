#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"
require "stringio"

class Tefil::ColumnAnalyzer
  #public :analyze, :print_size
end

class TC_ColumnAnalyzer < Test::Unit::TestCase
  def setup
    @c00 = Tefil::ColumnAnalyzer.new
  #  @c01 = Tefil::ColumnAnalyzer.new({:just => :right})
  #  @c02 = Tefil::ColumnAnalyzer.new({:separator => ','})
  end

  #def test_print_size
  #  assert_equal(2, @c00.print_size('ab'))
  #  assert_equal(4, @c00.print_size('あい'))
  #  assert_equal(6, @c00.print_size('abあい'))
  #end

  #def test_analyze
  #  io = StringIO.new
  #  matrix = [
  #    ["a", "ab"],
  #    ["abc", "a"],
  #  ]
  #  @c00.analyze(matrix, io)
  #  io.rewind
  #  assert_equal("a   ab\nabc a\n", io.read)

  #  io = StringIO.new
  #  @c00.analyze(matrix, io, 2)
  #  io.rewind
  #  assert_equal("  a   ab\n  abc a\n", io.read)


  #  io = StringIO.new
  #  @c01.analyze(matrix, io)
  #  io.rewind
  #  assert_equal("  a ab\nabc  a\n", io.read)
  #  io.rewind

  #  io = StringIO.new
  #  @c02.analyze(matrix, io)
  #  io.rewind
  #  assert_equal("a  ,ab\nabc,a\n", io.read)

  #  #####
  #  io = StringIO.new
  #  matrix = [
  #    ["abc", "def"],
  #    ["あいう", "えおか"],
  #  ]
  #  @c00.analyze(matrix, io)
  #  io.rewind
  #  assert_equal("abc    def\nあいう えおか\n", io.read)

  #  ####
  #  
  #end
end

