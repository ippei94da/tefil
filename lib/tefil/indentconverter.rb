#! /usr/bin/env ruby
# coding: utf-8

class Tefil::IndentConverter < Tefil::TextFilterBase
  def initialize(old_char, old_width, new_char, new_width, options)
    @old_width = old_width
    @new_width = new_width
    @old_char  = old_char 
    @new_char  = new_char 
    super(options)
  end

  def process_stream(in_io, out_io)
    in_io.readlines.each do |line|
      /^(#{@old_char}*)(.*)$/ =~ line
      indent = $1
      body = $2
      new_indent = indent.size * @new_width / @old_width
      out_io.puts "#{@new_char * new_indent}#{body}"
    end
  end
end


