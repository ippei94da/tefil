class Tefil::EnglishSentence < Tefil::TextFilterBase

  END_CHAR = ['.', '?']
  NOT_END_WORDS = ["Fig.", "FIG."]

  def initialize(options = {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    super(options)
  end

  def process_stream(in_io, out_io)
    results = []
    words = []
    in_io.read.split.each do |word|
      words << word
      last_char = word.split('')[-1]
      if (END_CHAR.include?(last_char)) && (! NOT_END_WORDS.include?( word))
        results << words.join(" ")
        words = []
      end

      #sentence << char
      #if char == '.'
      #end
    end
    #pp results

    out_io.puts results.map{|lines| lines.strip}.join("\n")
  end

end

