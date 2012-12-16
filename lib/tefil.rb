#! /usr/bin/env ruby
# coding: utf-8

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
module TextFilter

  class NotRedefinedMethodError < Exception; end
  class TypeError < Exception; end

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
  def self.run(filenames, overwrite_flag = false)
    #p self; exit
    if filenames.size == 0 
      self.process_stream( $stdin, $stdout )
    else
      #p filenames
      filenames.each do |filename|
        if overwrite_flag
          tempfile = Tempfile.new("tefil", "/tmp")
          File.open(filename, "r") do |input_file|
            self.process_stream(input_file, tempfile)
          end
          tempfile.close
          tempfile.open
          File.open(filename, "w") do |output_file|
            tempfile.each { |line| output_file.puts(line) }
          end
        else
          File.open(filename, "r") do |input_file|
            self.process_stream(input_file, $stdout)
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
  # If not redefined, raise an exception TextFilter::NotRedefinedMethodError.
  def self.process_stream(in_io, out_io)
    raise NotRedefinedMethodError
  end

end

