#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::Statistics
  #public :process_stream
  #public :calc_sum, :calc_average, :calc_variance, :calc_standard_deviation

end

class TC_Statistics < Test::Unit::TestCase

  TOLERANCE = 1.0E-10

  def setup
    @s00 = Tefil::Statistics.new()
  end

  def test_process_stream
    # stdin -> stdout
    $stdin = StringIO.new
    $stdin.puts "1.0"
    $stdin.puts "2.0"
    $stdin.puts "3.0"
    $stdin.rewind
    #str = capture_stdout{}
    result = capture_stdout{ @s00.filter([])}
    correct =
      "sample:             3\n" +
      "highest:            3.0\n" +
      "lowest:             1.0\n" +
      "sum:                6.0\n" +
      "average:            2.0\n" +
      "variance:           0.6666666666666666\n" +
      "standard_deviation: 0.816496580927726\n"
    assert_equal(correct, result)
  end

  def test_calc_sum
    assert_equal(6.0, Tefil::Statistics.calc_sum([1.0, 2.0, 3.0]))
  end

  def test_calc_average
    assert_equal(2.0, Tefil::Statistics.calc_average([1.0, 2.0, 3.0]))
  end

  def test_calc_variance
    assert_in_delta(0.6666666666666666, Tefil::Statistics.calc_variance([1.0, 2.0, 3.0]), TOLERANCE)
  end

  def test_calc_standard_deviation
    assert_in_delta(0.816496580927726, Tefil::Statistics.calc_standard_deviation([1.0, 2.0, 3.0]), TOLERANCE)
  end

end

