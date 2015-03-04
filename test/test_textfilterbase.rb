require 'helper'

require "test/unit"
require "tefil.rb"
require "stringio"
require "tempfile"
require "fileutils"

class SampleFilter < Tefil::TextFilterBase
  def process_stream(in_file, out_file)
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
    @t00 = SampleFilter.new
    $stdin = STDIN
    $stdout = STDOUT
    @t01 = SampleFilter.new({:overwrite => true})

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

  def test_filter
    # stdin -> stdout
    $stdin = StringIO.new
    $stdin.puts "abc"
    $stdin.puts "def"
    $stdin.rewind
    $stdout = StringIO.new
    @t00.filter([])
    $stdout.rewind
    t = $stdout.readlines
    assert_equal([ "Abc\n", "def\n" ], t)
    $stdout.close

    # 1 file-> stdout
    setup
    $stdout = StringIO.new
    @t00.filter([TMP00])
    $stdout.rewind
    output = $stdout.readlines
    assert_equal(["Abc\n", "def\n"], output)
    $stdout.close
    tmp00 = File.open(TMP00, "r").readlines
    assert_equal(["abc\n", "def\n"], tmp00)
    tmp01 = File.open(TMP01, "r").readlines
    assert_equal(["abc\n", "def\n", "cab\n"], tmp01)

    # 2 files -> stdout
    setup
    $stdout = StringIO.new
    @t00.filter([TMP00, TMP01])
    $stdout.rewind
    output = $stdout.readlines
    assert_equal(["Abc\n", "def\n", "Abc\n", "def\n", "cAb\n"],
                 output)
    $stdout.close
    tmp00 = File.open(TMP00, "r").readlines
    assert_equal(["abc\n", "def\n"], tmp00)
    tmp01 = File.open(TMP01, "r").readlines
    assert_equal(["abc\n", "def\n", "cab\n"], tmp01)

    # Not found
    assert_raise(Errno::ENOENT){ @t00.filter([""]) }
    assert_raise(Errno::ENOENT){ @t01.filter([""]) }
  end

  def test_filter_overwrite
    # 1 file-> stdout
    setup
    $stdout = StringIO.new
    @t01.filter([TMP00])
    $stdout.rewind
    tmp = $stdout.readlines
    assert_equal([], tmp)
    $stdout.close
    tmp = File.open(TMP00, "r").readlines
    assert_equal(["Abc\n", "def\n"], tmp)
    tmp = File.open(TMP01, "r").readlines
    assert_equal(["abc\n", "def\n", "cab\n"], tmp)

    # 2 files -> stdout
    setup
    $stdout = StringIO.new
    @t01.filter([TMP00, TMP01])
    $stdout.rewind
    stdout = $stdout.readlines
    assert_equal([], stdout)
    $stdout.close
    tmp = File.open(TMP00, "r").readlines
    assert_equal(["Abc\n", "def\n"], tmp)
    tmp = File.open(TMP01, "r").readlines
    assert_equal(["Abc\n", "def\n", "cAb\n"], tmp)
  end

#  def test_self_filter
#    $stdin = StringIO.new
#    $stdin.puts "abc"
#    $stdin.puts "def"
#    $stdin.rewind
#    $stdout = StringIO.new
#    SampleFilter.filter([], true)
#    $stdout.rewind
#    t = $stdout.readlines
#    assert_equal([ "Abc\n", "def\n" ], t)
#    $stdout.close
#
#    # 単数のファイルを指定。
#    # overwrite なし。
#    setup
#    $stdout = StringIO.new
#    SampleFilter.filter([TMP00])
#    $stdout.rewind
#    tmp = $stdout.readlines
#    assert_equal(["Abc\n", "def\n"], tmp)
#    $stdout.close
#    tmp = File.open(TMP00, "r").readlines
#    assert_equal(["abc\n", "def\n"], tmp)
#    tmp = File.open(TMP01, "r").readlines
#    assert_equal(["abc\n", "def\n", "cab\n"], tmp)
#
#    # 複数のファイルを指定。
#    # overwrite なし。
#    setup
#    $stdout = StringIO.new
#    SampleFilter.filter([TMP00, TMP01])
#    $stdout.rewind
#    tmp = $stdout.readlines
#    assert_equal(["Abc\n", "def\n", "Abc\n", "def\n", "cAb\n"], tmp)
#    $stdout.close
#    tmp = File.open(TMP00, "r").readlines
#    assert_equal(["abc\n", "def\n"], tmp)
#    tmp = File.open(TMP01, "r").readlines
#    assert_equal(["abc\n", "def\n", "cab\n"], tmp)
#
#
#  end

end

