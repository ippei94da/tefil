# coding: utf-8
class Tefil::LineSplitter < Tefil::TextFilterBase

  def initialize(target_strs: , except_words: [], options: {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    @target_strs = target_strs
    @except_words = except_words
    super(options)
  end

  def process_stream(in_io, out_io)
    results = []
    #words = []
 
    # prepare substitute info to get back to original for except rule.
    sub_except_words = Marshal.load(Marshal.dump(@except_words))
    @target_strs.each do |char|
      sub_except_words.map do |word|
        word.gsub!(char, char + "\n")
      end
    end
    #pp sub_except_words; exit

    in_io.read.strip.split("\n").each do |line|
      #new_line = ''
      #line.gsub!("\n", ' ')
      #line.strs.each do |char|
      #  new_line += char
      #  new_line += "\n" if (@target_strs.include?(char))
      #end
      #@except_words.each do |word|
      #  new_line.gsub!(/#{word}\n/, word)
      #end
      #new_line.gsub!(/\n  */, "\n")
      #new_line.strip!
      #new_line.gsub!(/  */, " ")
      #results << new_line

      @target_strs.each do |char|
        line.gsub!(char, char + "\n")
      end
      #pp line
      @except_words.each_with_index do |word, index|
        line.gsub!(/#{sub_except_words}\n/, word)
      end
      # 行の頭と末尾の空白 strip
      line.gsub!(/\n  */, "\n")
      line.strip!
      line.gsub!(/  */, " ")
      results << line
    end
    out_io.puts results.join("\n")
  end

end

