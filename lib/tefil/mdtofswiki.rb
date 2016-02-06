#! /usr/bin/env ruby
# coding: utf-8

class Tefil::MdToFswiki < Tefil::TextFilterBase
  #def initialize(options)
  #  super(options)
  #end

  def process_stream(in_io, out_io)
    # 行頭処理
    in_io.readlines.each do |line|
      if    /^!!!/      =~ line;      then; new_line = line.sub(/^!!!/     , "#")
      elsif /^!!/       =~ line;      then; new_line = line.sub(/^!!/      , "##")
      elsif /^!/        =~ line;        then; new_line = line.sub(/^!/       , "###")
      elsif /^\*\*\*\*/ =~ line; then; new_line = line.sub(/^\*\*\*\*/, "      *")
      elsif /^\*\*\*/   =~ line;   then; new_line = line.sub(/^\*\*\*/  , "    *")
      elsif /^\*\*/     =~ line;     then; new_line = line.sub(/^\*\*/    , "  *")
      elsif /^\*/       =~ line;       then; new_line = line.sub(/^\*/      , "*")
      elsif /^\+\+\+\+/ =~ line; then; new_line = line.sub(/^\+\+\+\+/, "      0.")
      elsif /^\+\+\+/   =~ line;   then; new_line = line.sub(/^\+\+\+/  , "    0.")
      elsif /^\+\+/     =~ line;     then; new_line = line.sub(/^\+\+/    , "  0.")
      elsif /^\+/       =~ line;       then; new_line = line.sub(/^\+/      , "0.")
      elsif /^ /        =~ line;        then; new_line = line.sub(/^ /       , "    ")
      elsif /^----/     =~ line;     then; new_line = line.sub(/^----/    , "---")
      else
        new_line = line
      end

      # 行中要素の処理
      new_line.gsub!(/\'\'\'/, '**')
      new_line.gsub!(/\'\'/, '*')
      if /\[(.*)\|(.*)\]/ =~ new_line # 複数ある場合は非対応。
        #puts "■■■"
        str = $1
        url = $2
        new_line.sub!(/\[(.*)\|(.*)\]/, "[#{str}](#{url})")
      end

      # 出力
      out_io.puts new_line
    end
  end
end


