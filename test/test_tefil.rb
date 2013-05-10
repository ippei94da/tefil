require 'helper'

require "test/unit"
require "tefil.rb"
require "stringio"
require "tempfile"
require "fileutils"

module Tefil
  def self.process_stream(in_file, out_file)
    results = []
    in_file.each do |line|
      out_file.puts line.sub('a', 'A')
    end
  end
end

class TestTefil < Test::Unit::TestCase
  TMP00 = "test/tmp00"
  TMP01 = "test/tmp01"

  def setup
    FileUtils.rm TMP00 if File.exist? TMP00
    FileUtils.rm TMP01 if File.exist? TMP01
    File.open(TMP00, "w") do |io|
      io.puts "abc"
      io.puts "def"
    end
    File.open(TMP01, "w") do |io|
      io.puts "abc"
      io.puts "def"
      io.puts "cab"
    end
  end

  def teardown
    FileUtils.rm TMP00 if File.exist? TMP00
    FileUtils.rm TMP01 if File.exist? TMP01
  end

  def test_self_run
    # Not found
    assert_raise(Errno::ENOENT){ Tefil.run([""]) }
    assert_raise(Errno::ENOENT){ Tefil.run([""], true) }

    # ファイル指定なしで標準入力
    $stdin = StringIO.new
    $stdin.puts "abc"
    $stdin.puts "def"
    $stdin.rewind
    # stdout
    $stdout = StringIO.new
    Tefil.run([], false)
    $stdout.rewind
    t = $stdout.readlines
    assert_equal([ "Abc\n", "def\n" ], t)
    $stdout.close

    $stdin = StringIO.new
    $stdin.puts "abc"
    $stdin.puts "def"
    $stdin.rewind
    $stdout = StringIO.new
    Tefil.run([], true)
    $stdout.rewind
    t = $stdout.readlines
    assert_equal([ "Abc\n", "def\n" ], t)
    $stdout.close

    # 単数のファイルを指定。
    # overwrite なし。
    setup
    $stdout = StringIO.new
    Tefil.run([TMP00])
    $stdout.rewind
    tmp = $stdout.readlines
    assert_equal(["Abc\n", "def\n"], tmp)
    $stdout.close
    tmp = File.open(TMP00, "r").readlines
    assert_equal(["abc\n", "def\n"], tmp)
    tmp = File.open(TMP01, "r").readlines
    assert_equal(["abc\n", "def\n", "cab\n"], tmp)

    # overwrite あり
    setup
    $stdout = StringIO.new
    Tefil.run([TMP00], true)
    $stdout.rewind
    tmp = $stdout.readlines
    assert_equal([], tmp)
    $stdout.close
    tmp = File.open(TMP00, "r").readlines
    assert_equal(["Abc\n", "def\n"], tmp)
    tmp = File.open(TMP01, "r").readlines
    assert_equal(["abc\n", "def\n", "cab\n"], tmp)

    # 複数のファイルを指定。
    # overwrite なし。
    setup
    $stdout = StringIO.new
    Tefil.run([TMP00, TMP01])
    $stdout.rewind
    tmp = $stdout.readlines
    assert_equal(["Abc\n", "def\n", "Abc\n", "def\n", "cAb\n"], tmp)
    $stdout.close
    tmp = File.open(TMP00, "r").readlines
    assert_equal(["abc\n", "def\n"], tmp)
    tmp = File.open(TMP01, "r").readlines
    assert_equal(["abc\n", "def\n", "cab\n"], tmp)

    # overwrite あり。
    setup
    $stdout = StringIO.new
    Tefil.run([TMP00, TMP01], true)
    $stdout.rewind
    stdout = $stdout.readlines
    assert_equal([], stdout)
    $stdout.close
    tmp = File.open(TMP00, "r").readlines
    assert_equal(["Abc\n", "def\n"], tmp)
    tmp = File.open(TMP01, "r").readlines
    assert_equal(["Abc\n", "def\n", "cAb\n"], tmp)

    # グローバル変数の標準出力、標準入力を元に戻す。
    $stdout = STDOUT
    $stdin  = STDIN
  end

end

