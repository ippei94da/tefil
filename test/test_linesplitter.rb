#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

# 元々の行末は保存する。
# 消すようにすると、空行などの処理が面倒になる。
class TC_LineSplitter < Test::Unit::TestCase
  def setup
    @test00 = Tefil::LineSplitter.new(separators: %w(.))
  end

  def test_process_stream
    # divide
    in_io = StringIO.new
    in_io.puts "Abc def. Ghi jhk."
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "Abc def.\n Ghi jhk.\n"
    assert_equal(correct, result)

    # 行末の保存
    in_io = StringIO.new
    in_io.puts "Abc def\nGhi jhk."
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "Abc def\nGhi jhk.\n"
    assert_equal(correct, result)

    # indent
    in_io = StringIO.new
    in_io.puts "  Abc def. Ghi jhk.\n"
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "  Abc def.\n Ghi jhk.\n"
    assert_equal(correct, result)

    # empty line
    in_io = StringIO.new
    in_io.puts "Abc def.\n\nGhi jhk.\n"
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "Abc def.\n\n\nGhi jhk.\n"
    assert_equal(correct, result)

    # Fig.
    in_io = StringIO.new
    in_io.puts "Including Fig. 3. Fig. 3? Fig.\n4 does' not exist."
    in_io.rewind
    out_io = StringIO.new
    @test00.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "Including Fig.\n 3.\n Fig.\n 3? Fig.\n\n4 does' not exist.\n"
    assert_equal(correct, result)
  end

  def test_process_stream_strip
    # strip
    test10 = Tefil::LineSplitter.new(separators: %w(.), indent_mode: :strip)
    in_io = StringIO.new
    in_io.puts "  Abc def. Ghi jhk.\n"
    in_io.rewind
    out_io = StringIO.new
    test10.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "Abc def.\nGhi jhk.\n"
    assert_equal(correct, result)
  end

  #def test_process_stream_indent
  #  # strip
  #  test10 = Tefil::LineSplitter.new(separators: %w(.), indent_mode: :indent)
  #  in_io = StringIO.new
  #  in_io.puts "  Abc def. Ghi jhk.\n"
  #  in_io.rewind
  #  out_io = StringIO.new
  #  test10.process_stream(in_io, out_io)
  #  out_io.rewind
  #  result = out_io.read
  #  correct = "  Abc def.\n  Ghi jhk.\n"
  #  assert_equal(correct, result)
  #end

  def test_process_stream_except
    # except
    in_io = StringIO.new
    in_io.puts "Including Fig.3. Fig. 3? Fig.\n4 does' not exist.\n"
    in_io.rewind
    out_io = StringIO.new
    test10 = Tefil::LineSplitter.new(separators: ["."], except_words: ["FIG.", "Fig."])
    test10.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "Including Fig.3.\n Fig. 3? Fig.\n4 does' not exist.\n"
    assert_equal(correct, result)
  end

  def test_process_stream_japanese
    # Japanese kutouten
    test10 = Tefil::LineSplitter.new(separators: %w(. 。))
    in_io = StringIO.new
    in_io.puts "あいうえお。かき\nくけこ。"
    in_io.rewind
    out_io = StringIO.new
    test10.process_stream(in_io, out_io)
    out_io.rewind
    result = out_io.read
    correct = "あいうえお。\nかき\nくけこ。\n"
    assert_equal(correct, result)
  end

end


