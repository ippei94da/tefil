#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::LineSubstituter
  public :process_stream
end

class TC_LineSubstituter < Test::Unit::TestCase
  def setup
    @is00 = Tefil::LineSubstituter.new('abc', 'XYZ')
    @is01 = Tefil::LineSubstituter.new('abc', 'XYZ', {:global => true})
  end

  def test_process_stream
    setup
    $stdin = StringIO.new
    $stdin.puts "abcdabcd"
    $stdin.puts "ABCDABCD"
    $stdin.rewind
    $stdout = StringIO.new
    @is00.filter([])
    $stdout.rewind
    t = $stdout.readlines
    assert_equal("XYZdabcd\n", t.shift)
    assert_equal("ABCDABCD\n", t.shift)
    $stdout.close

    setup
    $stdin = StringIO.new
    $stdin.puts "abcdabcd"
    $stdin.puts "ABCDABCD"
    $stdin.rewind
    $stdout = StringIO.new
    @is01.filter([])
    $stdout.rewind
    t = $stdout.readlines
    assert_equal("XYZdXYZd\n", t.shift)
    assert_equal("ABCDABCD\n", t.shift)
    $stdout.close
  end
end

