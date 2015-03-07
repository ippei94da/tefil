class Tefil::IndentStatistics < Tefil::TextFilterBase

  HISTGRAM_LIMIT = 50

  def initialize(options = {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    super(options)
  end

  def process_stream(in_io, out_io)
    frequencies = {}
    in_io.readlines.each do |line|
      #/^(\s*)/ =~ line #改行文字が含まれる。
      /^( *)/ =~ line
      width = $1.size
      frequencies[width] ||= 0
      frequencies[width] += 1
    end

    if @minimum
      frequencies.delete(0)
      output = frequencies.keys.min
      output = 0 if frequencies.empty?
    else
      output = ''
      output = "\n" if ARGV.size >= 2
      output += self.histgram(frequencies)
    end

    out_io.puts output
  end

  def histgram(frequencies)
    result = ''
    max = frequencies.values.max
    frequencies.keys.sort.each do |key|
      num = frequencies[key]
      num = num * HISTGRAM_LIMIT / max if max > HISTGRAM_LIMIT
      result += sprintf("%2d|", key)
      result += "*" * num
      result += "\n"
    end
    result
  end
end

