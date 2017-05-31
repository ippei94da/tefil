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

  # keys should be array including keys or key=value items)  as like:
  #   ['1', '2']
  #   ['1=str1', '2=str2']
  #   ['1=str1', '2']
  def initialize(keys = [])
    @nums_values = {}
    @keys = []
    keys.each do |str|
      if str.include? '='
        key, value = str.split('=')
        @nums_values[key.to_i-1] = value
      else
        @keys << str
      end
    end
    super({})
  end

  private

  def process_stream(in_io, out_io)
    lines = in_io.readlines

    # delete line consist of one character 
    lines.delete_if {|line| line.split.uniq.size == 1}

    ranges = get_ranges(projection_ary(lines))
    items_list = lines.map do |line|
      ranges.map { |range| line[range].strip }
    end

    # screen items
    items_head = items_list[0]
    items_list.select! do |items|
      flag = true
      @nums_values.each do |key, value|
        if items[key] != value
          flag = false
          break
        end
      end
      flag
    end

    # output head
    results = []
    results << (1..(items_head.size)).to_a.map{|v| v.to_s}
    #pp items_list[0]
    #pp items_head
    #exit
    results << items_head unless items_list[0] == items_head
    results += items_list
    Tefil::ColumnFormer.new.form(results, out_io)

    out_io.puts
    out_io.puts "All:       #{lines.size}"
    out_io.print "Extracted: #{items_list.size}"
    conditions = []
    @nums_values.each do |key, val|
      conditions << "#{key}=#{val}"
    end
    out_io.puts " (#{conditions.join(' ')})"
    out_io.puts

    if items_list.size != 0
      results = []
      results << %w(key head types)

      ranges.each_with_index do |range, i|
        results << [(i+1).to_s, lines[0][range].strip, 
          items_list.map {|items| items[i]}.sort.uniq.size.to_s
        ]
      end

      Tefil::ColumnFormer.new.form(results, out_io)
    end

    unless @keys.empty?
      out_io.puts
      out_io.puts "key analysis"
      @keys.each do |key|
        out_io.puts "(key=#{key})"
        values = items_list.map{|items| items[key.to_i-1]}
        names = values.sort.uniq
        results = []
        names.each do |name|
          results << [name, values.count(name).to_s]
        end
        results.sort_by!{|v| v[1].to_i}
        Tefil::ColumnFormer.new.form(results, out_io)
        out_io.puts
      end
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

