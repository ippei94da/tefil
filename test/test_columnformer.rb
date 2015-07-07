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
    assert_equal("  a ab\nabc  a\n", io.read)

    io = StringIO.new
    @cf00.form(matrix, io, ",")
    io.rewind
    assert_equal("  a,ab\nabc, a\n", io.read)

    io = StringIO.new
    @cf00.form(matrix, io, " ", true )
    io.rewind
    assert_equal("a   ab\nabc a\n", io.read)
    io.rewind

    #####
    io = StringIO.new
    matrix = [
      ["abc", "def"],
      ["あいう", "えおか"],
    ]
    @cf00.form(matrix, io)
    io.rewind
    assert_equal("   abc    def\nあいう えおか\n", io.read)
  end
end

