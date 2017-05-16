#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

#class Tefil::IndentConverter
#  public :process_stream
#end

class TC_Statistics < Test::Unit::TestCase
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
end



