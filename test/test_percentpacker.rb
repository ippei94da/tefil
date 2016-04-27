#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::PercentPacker
  public :process_stream
end

class TC_PercentPacker < Test::Unit::TestCase
  def setup
    @pp00 = Tefil::PercentPacker.new()
  end

  def test_process_stream
    # stdin -> stdout
    $stdin = StringIO.new
    $stdin.puts '%E3%83%86%E3%82%B9%E3%83%88'
    $stdin.rewind
    #str = capture_stdout{}
    result = capture_stdout{ @pp00.filter([])}
    correct = "テスト\n"
    assert_equal(correct, result)
  end
end



