class Tefil::ZshEscaper < Tefil::TextFilterBase
  def process_stream(in_io, out_io)
    in_io.each do |line|
      out_io.puts line.escape_zsh
    end
  end
end


