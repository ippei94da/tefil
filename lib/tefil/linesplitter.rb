# coding: utf-8
class Tefil::LineSplitter < Tefil::TextFilterBase

  def initialize(target_chars: , except_words: [], options: {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    @target_chars = target_chars
    @except_words = except_words
    super(options)
  end

  def process_stream(in_io, out_io)
    results = []
    #words = []
    in_io.read.strip.split("\n").each do |line|
      new_line = ''
      #line.gsub!("\n", ' ')
      line.chars.each do |char|
        new_line += char
        new_line += "\n" if (@target_chars.include?(char))
      end
      @except_words.each do |word|
        new_line.gsub!(/#{word}\n/, word)
      end
      new_line.gsub!(/\n  */, "\n")
      new_line.strip!
      new_line.gsub!(/  */, " ")
      results << new_line
    end
    out_io.puts results.join("\n")
  end

end

