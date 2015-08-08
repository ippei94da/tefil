#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class TC_EnglishSentence < Test::Unit::TestCase
  def setup
    @test00 = Tefil::EnglishSentence.new()
  end

  def test_process_stream
    in_io = StringIO.new
    in_io.puts <<HERE
This is english converter. Text
to text conversion. A line a sentence. 
  Indented text.
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
This is english converter.
Text to text conversion.
A line a sentence.
Indented text.
HERE
    assert_equal(correct, result)

    # Fig.
    in_io = StringIO.new
    in_io.puts <<HERE
    Sentence including period like Fig.3. Fig. 3? Fig.
    4 does' not exist.
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
Sentence including period like Fig.3.
Fig. 3?
Fig. 4 does' not exist.
HERE
    assert_equal(correct, result)
  end
end


