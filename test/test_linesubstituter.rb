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
    str = capture_stdout{}
    result = capture_stdout{ @is00.filter([])}
    correct =
      "XYZdabcd\n" +
      "ABCDABCD\n"
    assert_equal(correct, result)


    setup
    $stdin = StringIO.new
    $stdin.puts "abcdabcd"
    $stdin.puts "ABCDABCD"
    $stdin.rewind
    str = capture_stdout{}
    result = capture_stdout{ @is01.filter([])}
    correct =
      "XYZdXYZd\n" +
      "ABCDABCD\n"
    assert_equal(correct, result)

  end
end

