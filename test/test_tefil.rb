require 'helper'

require "test/unit"
require "tefil.rb"
require "stringio"
require "tempfile"
require "fileutils"

module TextFilter
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
    assert_raise(Errno::ENOENT){ TextFilter.run([""]) }
    assert_raise(Errno::ENOENT){ TextFilter.run([""], true) }

    # ファイル指定なしで標準入力
    $stdin = StringIO.new
    $stdin.puts "abc"
    $stdin.puts "def"
    $stdin.rewind
    # stdout
    $stdout = StringIO.new
    TextFilter.run([], false)
    $stdout.rewind
    t = $stdout.readlines
    assert_equal([ "Abc\n", "def\n" ], t)
    $stdout.close

    $stdin = StringIO.new
    $stdin.puts "abc"
    $stdin.puts "def"
    $stdin.rewind
    $stdout = StringIO.new
    TextFilter.run([], true)
    $stdout.rewind
    t = $stdout.readlines
    assert_equal([ "Abc\n", "def\n" ], t)
    $stdout.close

    # 単数のファイルを指定。
    # overwrite なし。
    setup
    $stdout = StringIO.new
    TextFilter.run([TMP00])
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
    TextFilter.run([TMP00], true)
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
    TextFilter.run([TMP00, TMP01])
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
    TextFilter.run([TMP00, TMP01], true)
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

  def test_textfilter_command
    #result = `echo "ab" | textfilter a A`
    #assert_equal("Ab\n", result)

    #setup
    #result = `textfilter a A #{TMP00}`
    #assert_equal("Abc\ndef\n", result)
    #str = File.open(TMP00, "r").read
    #assert_equal("abc\ndef\n", str)

    #setup
    #result = `textfilter -o a A #{TMP00}`
    #assert_equal("", result)
    #str = File.open(TMP00, "r").read
    #assert_equal("Abc\ndef\n", str)
  end

end

