#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::Calculator
  public :process_stream
end

class TC_Calculator < Test::Unit::TestCase
  def setup
    @is00 = Tefil::Calculator.new
  end

  def test_process_stream
    setup
    $stdin = StringIO.new
    $stdin.puts "1+2"
    $stdin.puts "0.1"
    $stdin.puts "-0.1"
    $stdin.puts "0.0"
    $stdin.rewind
    str = capture_stdout{}
    result = capture_stdout{ @is00.filter([])}
    correct =
      "3\n" +
      "0.1\n" +
      "-0.1\n" +
      "0.0\n"
    assert_equal(correct, result)

    setup
    $stdin = StringIO.new
    $stdin.puts "2^3"
    $stdin.rewind
    str = capture_stdout{}
    result = capture_stdout{ @is00.filter([])}
    correct = "8\n"
    assert_equal(correct, result)

    setup
    $stdin = StringIO.new
    $stdin.puts "2^{1+2}"
    $stdin.rewind
    str = capture_stdout{}
    result = capture_stdout{ @is00.filter([])}
    correct = "8\n"
    assert_equal(correct, result)

  end

  #なぜか変換されないが、コマンド経由ならいける。
  #def test_times
  #  setup
  #  $stdin = StringIO.new
  #  $stdin.puts "2 \times 3"
  #  $stdin.rewind
  #  str = capture_stdout{}
  #  result = capture_stdout{ @is00.filter([])}
  #  correct = "6\n"
  #  assert_equal(correct, result)
  #end

end

