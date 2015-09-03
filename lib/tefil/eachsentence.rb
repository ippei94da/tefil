class Tefil::EachSentence < Tefil::TextFilterBase

  END_CHAR = %w(. ? ． 。)
  NOT_END_WORDS = ["Fig.", "FIG."]

  def initialize(options = {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    super(options)
  end

  def process_stream(in_io, out_io)
    results = []
    words = []
    in_io.read.strip.split("\n").each do |line|
      new_line = ''
      #line.gsub!("\n", ' ')
      line.chars do |char|
        new_line += char
        new_line += "\n" if (END_CHAR.include?(char))
      end
      NOT_END_WORDS.each do |word|
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

