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
    ## stdin -> stdout
    #$stdin = StringIO.new
    #$stdin.puts "a"
    #$stdin.puts "  b"
    #$stdin.puts "    c"
    #$stdin.puts "  d"
    #$stdin.puts "    e"
    #$stdin.puts "    f"
    #$stdin.rewind
    #$stdout = StringIO.new
    #@is00.filter([])
    #$stdout.rewind
    #t = $stdout.readlines
    #assert_equal("a\n", t.shift)
    #assert_equal("    b\n", t.shift)
    #assert_equal("        c\n", t.shift)
    #assert_equal("    d\n", t.shift)
    #assert_equal("        e\n", t.shift)
    #assert_equal("        f\n", t.shift)
    #$stdout.close
  end
end

