
#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::Correlation
  #public :process_stream
  #public :calc_sum, :calc_average, :calc_variance, :calc_standard_deviation

end

class TC_Correlation < Test::Unit::TestCase

  TOLERANCE = 1.0E-10

  def setup
    @c00 = Tefil::Correlation.new()
  end

  def test_process_stream
    # stdin -> stdout
    $stdin = StringIO.new
    $stdin.puts "12 28"
    $stdin.puts "38 35"
    $stdin.puts "28 55"
    $stdin.puts "50 87"
    $stdin.puts "76 93"
    $stdin.rewind
    #str = capture_stdout{}
    result = capture_stdout{ @c00.filter([])}
    #correct = "correlation coefficient : 0.865450949\n"
    correct = "correlation coefficient : 0.865451\nleast square 1st degree : y = a1 x + a0, a1 = 1.060564, a0 = 16.328975\n"
    assert_equal(correct, result)
  end

  def test_calc_covariance
    result = Tefil::Correlation.calc_covariance(
                   [12, 38, 28, 50, 76],
                   [28, 35, 55, 87, 93])
    assert_in_delta(493.12, result, TOLERANCE)
  end

  def test_calc_correlation_coefficient
    result = Tefil::Correlation.calc_correlation_coefficient(
                   [12, 38, 28, 50, 76],
                   [28, 35, 55, 87, 93])
    assert_in_delta(0.865450949, result, TOLERANCE)
    

  end

end
