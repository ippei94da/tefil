#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Tefil::ColumnFormer

  def self.form(matrix, io = $stdout, separator = " ", left = false)
    #Obtain max length for each column.
    max_lengths = []
    matrix.each do |row|
      row.each_with_index do |item, index|
        item = item.to_s
        max_lengths[index] ||= 0
        #size = item.size
        size = print_size(item)
        max_lengths[index] = size if max_lengths[index] < size
      end
    end

    #Output
    matrix.each do |row|
      new_items = []

      form_left = ""
      form_left = "-" if left

      row.each_with_index do |item, index|
        new_items[index] = sprintf("%#{form_left}#{max_lengths[index]}s", item)
      end
      io.puts new_items.join(separator).sub(/ +$/, "")
    end
  end

  private

  def self.print_size(string)
    string.each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
  end
end

