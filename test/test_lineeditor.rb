#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::LineEditor
  public :process_stream
end

class TC_LineEditor < Test::Unit::TestCase
  def setup
    @le00 = Tefil::LineEditor.new()
  end

  def test_process_stream
    assert(false)
    # stdin -> stdout
    $stdin = StringIO.new
    $stdin.puts "ippei"
    $stdin.rewind
    $stdout = StringIO.new
    @le00.filter([])
    $stdout.rewind
    t = $stdout.readlines
    assert_equal("eiipp\n", t.shift)
    $stdout.close
  end
end


