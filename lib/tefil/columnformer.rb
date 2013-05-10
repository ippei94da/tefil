#! /usr/bin/env ruby
# coding: utf-8

#
#
#
module Tefil::ColumnFormer
  def self.form(matrix, io = $stdout, separator = " ", left = false)
    #Obtain max length for each column.
    max_lengths = []
    matrix.each do |row|
      row.each_with_index do |item, index|
        max_lengths[index] ||= 0
        size = item.size
        max_lengths[index] = size if max_lengths[index] < size
      end
    end

    #Output
    matrix.each do |row|
      new_items = []

      form_left = ""
      form_left = "-" if left

      row.each_with_index do |item, index|
        new_items[index] = sprintf("%#{form_left}#{max_lengths[index]}s", item )
      end
      io.puts new_items.join(separator).sub(/ +$/, "")
    end
  end
end

