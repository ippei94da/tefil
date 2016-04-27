class Tefil::PercentPacker < Tefil::TextFilterBase
  def process_stream(in_io, out_io)
    in_io.each do |line|
      old_chars = line.split("")
      new_str = ""
      new_index = 0
      old_index = 0
      while old_index < old_chars.size
        if old_chars[old_index] == "%"
          new_str += [old_chars[(old_index + 1) .. (old_index + 2)].join].pack("H*")
          old_index += 2
        else
          new_str += old_chars[old_index]
        end
        old_index += 1
        new_index += 1
      end
      out_io.print new_str
    end
  end
end

