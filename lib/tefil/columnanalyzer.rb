#! /usr/bin/env ruby
# coding: utf-8

#INPUT_SEPARATOR = /\s+/

#class String
#  #http://www.techscore.com/blog/2012/12/25/
#  #def mb_ljust(width, padding=' ')
#  def left_just(width, padding=' ')
#    output_width = each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
#    padding_size = [0, width - output_width].max
#    self + padding * padding_size
#  end
#
#  #def mb_rjust(width, padding=' ')
#  def right_just(width, padding=' ')
#    output_width = each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
#    padding_size = [0, width - output_width].max
#    padding * padding_size + self
#  end
#end


#
#
#
class Tefil::ColumnAnalyzer < Tefil::TextFilterBase

  #def initialize(options = {})
  #  @separator = options[:separator] || ' '
  #  super(options)
  #end


  private

  def process_stream(in_io, out_io)
    lines = in_io.readlines
    projection_ary(lines)




  end

  #def print_size(string)
  #  string.each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
  #end

  # 全ての文字列の最大長を要素数とする配列で、
  # 空白文字以外があれば true, 全て空白文字ならば false にした配列。
  def projection_ary(lines)
    max_length = lines.max_by{|line| line.size}.size
    results = Array.new(max_length).fill(false)
    lines.each do |line|
      line.chomp.size.times do |i|
        c = line[i]
        next if results[i] == true
        if c == ' '
          next
        else
          results[i] = true
        end
      end
    end
    results
  end

end

