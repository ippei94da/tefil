#! /usr/bin/env ruby
# coding: utf-8

INPUT_SEPARATOR = /\s+/

class String
  #http://www.techscore.com/blog/2012/12/25/
  #def mb_ljust(width, padding=' ')
  def left_just(width, padding=' ')
    output_width = each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
    padding_size = [0, width - output_width].max
    self + padding * padding_size
  end

  #def mb_rjust(width, padding=' ')
  def right_just(width, padding=' ')
    output_width = each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
    padding_size = [0, width - output_width].max
    padding * padding_size + self
  end
end


#
#
#
class Tefil::ColumnFormer < Tefil::TextFilterBase

  def initialize(options = {})
    @just = options[:just] || :left
    @separator = options[:separator] || ' '
    super(options)
  end

  #def form(matrix, io = $stdout, separator = " ", left = false)
  def form(matrix, io = $stdout, indent = 0)
    #Obtain max length for each column.
    max_lengths = []
    matrix.each do |row|
      row.each_with_index do |item, index|
        item = item.to_s
        max_lengths[index] ||= 0
        size = print_size(item)
        max_lengths[index] = size if max_lengths[index] < size
      end
    end

    #Output
    matrix.each do |row|
      new_items = []
      row.each_with_index do |item, index|
        item = item.to_s
        method = (@just.to_s + "_just").to_sym
        new_items[index] = item.send(method, max_lengths[index])
      end
      io.print(" " * indent)
      io.puts new_items.join(@separator).sub(/ +$/, "")
    end
  end


  private

  def process_stream(in_io, out_io)
    space_width = []
    rows = in_io.readlines.map do |line|
      #pp line
      line =~ /^(\s*)/
      space_width << $1.length
      line.strip.split(INPUT_SEPARATOR)
    end
    #form(rows, out_io, OPTIONS[:separator], OPTIONS[:left])
    form(rows, out_io, space_width.min)
  end

  def print_size(string)
    string.each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
  end

end

