#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::IndentConverter
  public :process_stream
end

class TC_IndentConverter < Test::Unit::TestCase
  def setup
    @ic00 = Tefil::IndentConverter.new(' ', 2, ' ', 4, {})
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
    $stdin.rewind
    #str = capture_stdout{}
    result = capture_stdout{ @ic00.filter([])}
    correct =
      "a\n" +
      "    b\n" +
      "        c\n" + 
      "    d\n" +     
      "        e\n" + 
      "        f\n"
    assert_equal(correct, result)
  end
end







