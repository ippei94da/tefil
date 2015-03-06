class Tefil::LineSubstituter < Tefil::TextFilterBase
  def process_stream(in_io, out_io)
    in_io.each do |line|
      if OPTIONS[:global]
        out_io.puts line.gsub(OLD_STR, NEW_STR)
      else
        out_io.puts line.sub(OLD_STR, NEW_STR)
      end
    end
  end
end



