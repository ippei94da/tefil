#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::IndentConverter
  public :process_stream
end

class TC_IndentStatistics < Test::Unit::TestCase
  def setup
    @is00 = Tefil::IndentStatistics.new()
  end

  def test_process_stream
    # stdin -> stdout
    $stdin = StringIO.new
    $stdin.puts "a"
    $stdin.puts "  b"
    $stdin.puts "    c"
    $stdin.puts "  d"
    $stdin.puts "    e"
    $stdin.puts "    f"
    $stdin.puts "  g"
    $stdin.puts "    h"
    $stdin.rewind
    #str = capture_stdout{}
    result = capture_stdout{ @is00.filter([])}
    correct =
      " 0|*\n" +
      " 2|***\n" +
      " 4|****\n"
    assert_equal(correct, result)
  end
end


