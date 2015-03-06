#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::LineSubstituter
  public :process_stream
end

class TC_LineSubstituter < Test::Unit::TestCase
  def setup
    @is00 = Tefil::LineSubstituter.new()
  end

  def test_process_stream
    assert(false)
    ## stdin -> stdout
    #$stdin = StringIO.new
    #$stdin.puts "a"
    #$stdin.puts "  b"
    #$stdin.puts "    c"
    #$stdin.puts "  d"
    #$stdin.puts "    e"
    #$stdin.puts "    f"
    #$stdin.puts "  g"
    #$stdin.puts "    h"
    #$stdin.rewind
    #$stdout = StringIO.new
    #@is00.filter([])
    #$stdout.rewind
    #t = $stdout.readlines
    #assert_equal(" 0|*\n", t.shift)
    #assert_equal(" 2|***\n", t.shift)
    #assert_equal(" 4|****\n", t.shift)
    #$stdout.close
  end
end



