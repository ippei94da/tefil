# coding: utf-8
class Tefil::LineSplitter < Tefil::TextFilterBase

  END_CHARS = %w(. ? ． 。)
  EXCEPT_WORDS = ["Fig.", "FIG."]

  def initialize(options = {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    @end_chars = options[:endchars] || END_CHARS
    @except_words = options[:excepts] || EXCEPT_WORDS
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
        new_line += "\n" if (@end_chars.include?(char))
      end
      EXCEPT_WORDS.each do |word|
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

