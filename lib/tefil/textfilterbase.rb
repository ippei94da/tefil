#! /usr/bin/env ruby
# coding: utf-8
#
#require "tefil"
require "tempfile"

# Module that provide a framework for text filters.
#
# Provide basic functions for a command like below:
#   Input:
#     - Without indicating filenames like "command.rb",
#       input data is eaten from STDIN.
#     - With indicating filenames like "command.rb *.txt",
#       input data is eaten from indicated files in order.
#       When the file which is in the filenames does not exist,
#       output report to STDERR.
#
#   Output:
#     - Without indicating "--overwrite" option,
#       output to STDOUT even from many files.
#     - With indicating "--overwrite" option,
#       - With indicating input files,
#         overwrite each file.
#       - Without indicating input files,
#         output to STDOUT in one stream.
#
# If indicated file(s) not found,
# this program notify on stderr and does not throw an exception.
#
class Tefil::TextFilterBase

  class NotRedefinedMethodError < Exception; end
  class TypeError < Exception; end

  def initialize(options = {})
    @overwrite = options[:overwrite]
  end

  # 保持している入力ファイル対して、順に処理を実行する。
  # filenames.size が 0 ならば STDIN からの入力を待つことになる。
  #
  # STDIN からの入力だった場合、出力先は必ず STDOUT になる。
  # STDIN からの入力ではない、すなわちファイル入力であった場合、
  #   - overwrite_flag が false ならば STDOUT に出力する。
  #   - overwrite_flag が true ならば 個々のファイルに上書きする。
  #
  # Process of each file is defined in 'process_stream' method.
  #
  #def self.filter(filenames, options)
  #  self.class.new(options).filter(filenames)
  #end

  def filter(filenames)
    @num_files = filenames.size
    input_io = $stdin
    output_io = $stdout
    if filenames.size == 0 
      process_stream( input_io, output_io)
    else
      filenames.each do |filename|
        @filename = filename
        input_io = File.open(filename, "r")
        output_io = Tempfile.new("tefil", "/tmp") if @overwrite

        begin
          process_stream(input_io, output_io)
        rescue ArgumentError, Errno::EISDIR
          $stderr.puts $!
          next
        end

        if @overwrite
          output_io.open
          File.open(filename, "w") do |overwrite_io|
            output_io.each { |line| overwrite_io.puts(line) }
          end
        end
      end
    end
  end


  private

  # Process a file.
  # An argument 'in_io' indicates an io (file handle) for input.
  # Another argument 'out_io' indicates an io (file handle) for output.
  # This method must be redefined in a subclass or be overridden.
  # If not redefined, raise an exception Tefil::NotRedefinedMethodError.
  def process_stream(in_io, out_io)
    raise NotRedefinedMethodError
  end

end

