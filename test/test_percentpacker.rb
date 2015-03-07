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
    $stdout = StringIO.new
    @pp00.filter([])
    $stdout.rewind
    t = $stdout.readlines
    assert_equal("テスト\n", t.shift)
    $stdout.close
  end
end



