#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"
require "stringio"

class TC_ColumnFormer < Test::Unit::TestCase
  def test_form
    io = StringIO.new
    matrix = [
      ["a", "ab"],
      ["abc", "a"],
    ]
    Tefil::ColumnFormer.form(matrix, io)
    io.rewind
    assert_equal("  a ab\nabc  a\n", io.read)

    io = StringIO.new
    Tefil::ColumnFormer.form(matrix, io, ",")
    io.rewind
    assert_equal("  a,ab\nabc, a\n", io.read)

    io = StringIO.new
    Tefil::ColumnFormer.form(matrix, io, " ", true )
    io.rewind
    assert_equal("a   ab\nabc a\n", io.read)
    io.rewind

  end
end

