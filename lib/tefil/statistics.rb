class Tefil::Statistics < Tefil::TextFilterBase

  HISTGRAM_LIMIT = 50

  def initialize(options = {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    super(options)
  end

  def self.calc_sum(data)
    result = 0.0
    data.each { |datum| result += datum }
    result
  end

  def self.calc_average(data, sum: nil)
    sum ||= calc_sum(data) 
    sum / data.size.to_f
  end

  def self.calc_variance(data, average: nil)
    average ||= calc_average(data)
    tmp = 0.0
    data.each { |datum| tmp += (datum - average)**2 }
    tmp / data.size.to_f
  end

  def self.calc_standard_deviation(data, variance: nil)
    variance ||= calc_variance(data)
    Math::sqrt(variance)
  end


  def process_stream(in_io, out_io)
    data = in_io.readlines.map{|l| l.to_f}
    sum                = self.class.calc_sum(data)
    average            = self.class.calc_average(data,            sum:      sum)
    variance           = self.class.calc_variance(data,           average:  average)
    standard_deviation = self.class.calc_standard_deviation(data, variance: variance)
  
    out_io.puts "sample:             #{data.size}\n"
    out_io.puts "highest:            #{data.max}\n"
    out_io.puts "lowest:             #{data.min}\n"
    out_io.puts "sum:                #{sum}"
    out_io.puts "average:            #{average}"
    out_io.puts "variance:           #{variance}"
    out_io.puts "standard_deviation: #{standard_deviation}"
  end


end


