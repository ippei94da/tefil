#! /usr/bin/env ruby
# coding: utf-8

class Tefil::FswikiToMd < Tefil::TextFilterBase
  #def initialize(options)
  #  super(options)
  #end

  def process_stream(in_io, out_io)

    in_io.readlines.each do |line|
      # 行頭処理
      case
      when line.sub!(/^!!!/      , '') then type = :head1
      when line.sub!(/^!!/       , '') then type = :head2
      when line.sub!(/^!/        , '') then type = :head3
      when line.sub!(/^\*\*\*\*/ , '') then type = :item4
      when line.sub!(/^\*\*\*/   , '') then type = :item3
      when line.sub!(/^\*\*/     , '') then type = :item2
      when line.sub!(/^\*/       , '') then type = :item1
      when line.sub!(/^\+\+\+\+/ , '') then type = :enum4
      when line.sub!(/^\+\+\+/   , '') then type = :enum3
      when line.sub!(/^\+\+/     , '') then type = :enum2
      when line.sub!(/^\+/       , '') then type = :enum1
      when line.sub!(/^ /        , '') then type = :pre
      when line.sub!(/^----/     , '') then type = :hline
      when line.sub!(/^\/\//     , '') then type = :comment
      else
        type = :plain
      end

      # 行中要素の処理
      line.gsub!(/\'\'\'/, '**')
      line.gsub!(/\'\'/, '*')
      if /\[(.*)\|(.*)\]/ =~ line # 複数ある場合は非対応。
        str = $1
        url = $2
        line.sub!(/\[(.*)\|(.*)\]/, "[#{str}](#{url})")
      end

      case
      when type == :head1   then line.sub!(/^/, "#"           )
      when type == :head2   then line.sub!(/^/, "##"          )
      when type == :head3   then line.sub!(/^/, "###"         )
      when type == :item4   then line.sub!(/^/, "      *"     )
      when type == :item3   then line.sub!(/^/, "    *"       )
      when type == :item2   then line.sub!(/^/, "  *"         )
      when type == :item1   then line.sub!(/^/, "*"           )
      when type == :enum4   then line.sub!(/^/, "      0."    )
      when type == :enum3   then line.sub!(/^/, "    0."      )
      when type == :enum2   then line.sub!(/^/, "  0."        )
      when type == :enum1   then line.sub!(/^/, "0."          )
      when type == :pre     then line.sub!(/^/, "    "        )
      when type == :hline   then line.sub!(/^/, "---"         )
      when type == :comment then line = "<!--#{line.chomp}-->"
      else # type == :pain  then  'do nothing'
      end

      # 出力
      out_io.puts line
    end
  end
end


