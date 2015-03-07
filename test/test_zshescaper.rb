#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::ZshEscaper
  public :process_stream
end

class TC_ZshEscaper < Test::Unit::TestCase
  def setup
    @is00 = Tefil::ZshEscaper.new()
  end

  def test_process_stream
    # stdin -> stdout
    $stdin = StringIO.new
    $stdin.puts "abcdABCD * * *"
    $stdin.rewind
    $stdout = StringIO.new
    @is00.filter([])
    $stdout.rewind
    t = $stdout.readlines
    assert_equal('abcdABCD\ \*\ \*\ \*' + "\n", t.shift)
    $stdout.close
  end
end



