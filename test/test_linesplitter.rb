#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

# 元々の行末は保存する。
# 消すようにすると、空行などの処理が面倒になる。
class TC_LineSplitter < Test::Unit::TestCase
  def setup
    @test00 = Tefil::LineSplitter.new()
  end

  def test_process_stream
    # divide
    in_io = StringIO.new
    in_io.puts <<HERE
Abc def. Ghi jhk.
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
Abc def.
Ghi jhk.
HERE
    assert_equal(correct, result)

    # 行末の保存
    in_io = StringIO.new
    in_io.puts <<HERE
Abc def
Ghi jhk.
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
Abc def
Ghi jhk.
HERE
    assert_equal(correct, result)

    # indent
    in_io = StringIO.new
    in_io.puts <<HERE
  Abc def
  Ghi jhk.
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
Abc def
Ghi jhk.
HERE
    assert_equal(correct, result)

    # empty line
    in_io = StringIO.new
    in_io.puts <<HERE
Abc def.

Ghi jhk.
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
Abc def.

Ghi jhk.
HERE
    assert_equal(correct, result)

    # Fig.
    in_io = StringIO.new
    in_io.puts <<HERE
    Including Fig.3. Fig. 3? Fig.
    4 does' not exist.
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
Including Fig.3.
Fig. 3?
Fig.
4 does' not exist.
HERE
    assert_equal(correct, result)

    # Japanese kutouten
    in_io = StringIO.new
    in_io.puts <<HERE
    あいうえお。かき
    くけこ。
HERE
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = <<HERE
あいうえお。
かき
くけこ。
HERE
    assert_equal(correct, result)
  end
end


