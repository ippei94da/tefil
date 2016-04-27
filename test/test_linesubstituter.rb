#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::LineSubstituter
  public :process_stream
end

class TC_LineSubstituter < Test::Unit::TestCase
  def setup
    @ls00 = Tefil::LineSubstituter.new('abc', 'XYZ')
    @ls01 = Tefil::LineSubstituter.new('abc', 'XYZ', {:global => true})
    @ls02 = Tefil::LineSubstituter.new('^a', 'A', {:regexp => true})
  end

  def test_process_stream
    setup
    $stdin = StringIO.new
    $stdin.puts "abcdabcd"
    $stdin.puts "ABCDABCD"
    $stdin.rewind
    str = capture_stdout{}
    result = capture_stdout{ @ls00.filter([])}
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
    result = capture_stdout{ @ls01.filter([])}
    correct =
      "XYZdXYZd\n" +
      "ABCDABCD\n"
    assert_equal(correct, result)

    setup
    $stdin = StringIO.new
    $stdin.puts "abcdabcd"
    $stdin.puts "ABCDABCD"
    $stdin.rewind
    str = capture_stdout{}
    result = capture_stdout{ @ls02.filter([])}
    correct =
      "Abcdabcd\n" +
      "ABCDABCD\n"
    assert_equal(correct, result)

  end
end

