class Tefil::Statistics < Tefil::TextFilterBase

  HISTGRAM_LIMIT = 50

  def initialize(options = {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    super(options)
  end

  def process_stream(in_io, out_io)
    data = in_io.readlines.map{|l| l.to_f}

    sum = 0.0
    data.each { |datum| sum += datum }

    average = sum / data.size.to_f

    #variance
    tmp = 0.0
    data.each { |datum| tmp += (datum - average)**2 }
    variance = tmp / data.size.to_f

    #standard deviation
    standard_deviation = Math::sqrt(variance)

    out_io.puts "highest:            #{data.max}\n"
    out_io.puts "lowest:             #{data.min}\n"
    out_io.puts "sum:                #{sum}"
    out_io.puts "average:            #{average}"
    out_io.puts "variance:           #{variance}"
    out_io.puts "standard_deviation: #{standard_deviation}"
  end

end


