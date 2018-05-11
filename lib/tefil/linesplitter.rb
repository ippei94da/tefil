# coding: utf-8
class Tefil::LineSplitter < Tefil::TextFilterBase

  def initialize(separators: , indent_mode: :no, except_words: [], options: {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    @separators = separators
    @except_words = except_words
    @indent_mode = indent_mode
    super(options)
  end

  def process_stream(in_io, out_io)
    results = []
 
    # prepare substitute info to get back to original for except rule.
    sub_except_words = Marshal.load(Marshal.dump(@except_words))
    @separators.each do |str|
      sub_except_words.map do |word|
        word.gsub!(str, str + "\n")
      end
    end

    in_io.read.split("\n").each do |line|
      #if @indent_mode == :indent
      #  /^( *)/ =~ line
      #  head_spaces = $1
      #end
      @separators.each do |str|
        line.gsub!(str, str + "\n")
      end
      @except_words.each_with_index do |word, index|
        line.gsub!(sub_except_words[index], word)
      end
      # 行の頭と末尾の空白 strip
      if @indent_mode == :strip
        line.gsub!(/\n  */, "\n")
        line.strip!
        line.gsub!(/  */, " ")
      end
      #if @indent_mode == :indent
      #  results << head_spaces + line
      #end
      results << line
    end
    out_io.puts results.join("\n")
  end

end

