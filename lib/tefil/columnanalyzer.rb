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
    ranges = get_ranges(projection_ary(lines))

    items_list = lines.map do |line|
      ranges.map { |range| line[range] }
    end

    out_io.puts "#{lines.size} lines"
    ranges.size.times do |i|
      out_io.print "column #{i}:"
      out_io.printf( "types: %d, ",
       items_list.map {|items| items[i]}.sort.uniq.size
      )
      pp lines
      out_io.printf( "head: %s", lines[0][ranges[i]])
      out_io.puts
    end
  end

  # true の範囲を示す二重配列を返す。
  # 各要素は 始点..終点 の各インデックスで出来た範囲。
  ## 各要素は[始点, 終点] の各インデックス。
  def get_ranges(ary)
    results = []
    start = nil
    prev = false
    ary << false # for true in final item
    ary.each_with_index do |cur, i|
      if prev == false && cur == true
        start = i
        prev = cur
      elsif prev == true && cur == false
        results << (start..(i - 1))
        prev = cur
      else
        next
      end
    end
    results
  end

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

