#! /usr/bin/env ruby
# coding: utf-8

class Tefil::MdToFswiki < Tefil::TextFilterBase
  #def initialize(options)
  #  super(options)
  #end

  def process_stream(in_io, out_io)

    in_io.readlines.each do |line|


      # 行頭処理
      case
      when line.sub!(/^\#\#\#/  , ''); then; type = :head3
      when line.sub!(/^\#\#/    , ''); then; type = :head2
      when line.sub!(/^\#/      , ''); then; type = :head1
      when line.sub!(/^      \*/, ''); then; type = :item4
      when line.sub!(/^    \*/  , ''); then; type = :item3
      when line.sub!(/^  \*/    , ''); then; type = :item2
      when line.sub!(/^\*/      , ''); then; type = :item1
      when line.sub!(/^      0./, ''); then; type = :enum4
      when line.sub!(/^    0./  , ''); then; type = :enum3
      when line.sub!(/^  0./    , ''); then; type = :enum2
      when line.sub!(/^0./      , ''); then; type = :enum1
      when line.sub!(/^    /    , ''); then; type = :pre
      when line.sub!(/^---/     , ''); then; type = :hr
      else                           ; then; type = :pain
      end

      # 行中要素の処理
      line.gsub!(/\**/, "'''")
      line.gsub!('*' , "''"  )
      if /\[(.*)\|(.*)\]/ =~ line # 複数ある場合は非対応。
        #puts "■■■"
        str = $1
        url = $2
        line.sub!(/\[(.*)\|(.*)\]/, "[#{str}](#{url})")
      end

      case
      when type == :head3 ; then;  line.sub!(/^/, "\#\#\#"  )
      when type == :head2 ; then;  line.sub!(/^/, "\#\#"    )
      when type == :head1 ; then;  line.sub!(/^/, "\#"      )
      when type == :item4 ; then;  line.sub!(/^/, "      \*")
      when type == :item3 ; then;  line.sub!(/^/, "    \*")
      when type == :item2 ; then;  line.sub!(/^/, "  \*" )
      when type == :item1 ; then;  line.sub!(/^/, "\*"   )
      when type == :enum4 ; then;  line.sub!(/^/, "      0.")
      when type == :enum3 ; then;  line.sub!(/^/, "    0.")
      when type == :enum2 ; then;  line.sub!(/^/, "  0." )
      when type == :enum1 ; then;  line.sub!(/^/, "0."   )
      when type == :pre   ; then;  line.sub!(/^/, "    " )
      when type == :hr    ; then;  line.sub!(/^/, "---"  )
      else type == :pain  ; then;                            
      end



'!'    
'!!'   
'!!!'  
'****' 
'***'  
'**'   
'*'    
'++++' 
'+++'  
'++'   
'+'    
' '    
'----' 

























      #if    /^\#\#\#/   =~ line; then; new_line = line.sub(/^\#\#\#/  , '!'    )
      #elsif /^\#\#/     =~ line; then; new_line = line.sub(/^\#\#/    , '!!'   )
      #elsif /^\#/       =~ line; then; new_line = line.sub(/^\#/      , '!!!'  )
      #elsif /^      \*/ =~ line; then; new_line = line.sub(/^      \*/, '****' )
      #elsif /^    \*/   =~ line; then; new_line = line.sub(/^    \*/  , '***'  )
      #elsif /^  \*/     =~ line; then; new_line = line.sub(/^  \*/    , '**'   )
      #elsif /^\*/       =~ line; then; new_line = line.sub(/^\*/      , '*'    )
      #elsif /^      0./ =~ line; then; new_line = line.sub(/^      0./, '++++' )
      #elsif /^    0./   =~ line; then; new_line = line.sub(/^    0./  , '+++'  )
      #elsif /^  0./     =~ line; then; new_line = line.sub(/^  0./    , '++'   )
      #elsif /^0./       =~ line; then; new_line = line.sub(/^0./      , '+'    )
      #elsif /^    /     =~ line; then; new_line = line.sub(/^    /    , ' '    )
      #elsif /^---/      =~ line; then; new_line = line.sub(/^---/     , '----' )
      #else
      #  new_line = line
      #end




      # 出力
      out_io.puts new_line
    end
  end
end


