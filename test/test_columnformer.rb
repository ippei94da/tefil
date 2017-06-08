#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"
require "stringio"

class Tefil::ColumnFormer
  public :form, :print_size
end

class TC_ColumnFormer < Test::Unit::TestCase
  def setup
    @cf00 = Tefil::ColumnFormer.new
    @cf01 = Tefil::ColumnFormer.new({:just => :right})
    @cf02 = Tefil::ColumnFormer.new({:separator => ','})
  end

  def test_print_size
    assert_equal(2, @cf00.print_size('ab'))
    assert_equal(4, @cf00.print_size('あい'))
    assert_equal(6, @cf00.print_size('abあい'))
  end

  def test_form
    io = StringIO.new
    matrix = [
      ["a", "ab"],
      ["abc", "a"],
    ]
    @cf00.form(matrix, io)
    io.rewind
    assert_equal("a   ab\nabc a\n", io.read)

    io = StringIO.new
    @cf00.form(matrix, io, 2)
    io.rewind
    assert_equal("  a   ab\n  abc a\n", io.read)

    io = StringIO.new
    @cf01.form(matrix, io)
    io.rewind
    assert_equal("  a ab\nabc  a\n", io.read)
    io.rewind

    io = StringIO.new
    @cf02.form(matrix, io)
    io.rewind
    assert_equal("a  ,ab\nabc,a\n", io.read)

    #####
    io = StringIO.new
    matrix = [
      ["abc", "def"],
      ["あいう", "えおか"],
    ]
    @cf00.form(matrix, io)
    io.rewind
    assert_equal("abc    def\nあいう えおか\n", io.read)

    ##### not string
    io = StringIO.new
    matrix = [
      [0, 1],
      [2, 3],
    ]
    @cf00.form(matrix, io)
    io.rewind
    assert_equal("0 1\n2 3\n", io.read)

    ####
    
  end
end

