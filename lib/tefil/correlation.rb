require 'malge'

class Tefil::Correlation < Tefil::TextFilterBase

  HISTGRAM_LIMIT = 50

  def initialize(options = {})
    options[:smart_filename] = true
    @minimum = options[:minimum]
    super(options)
  end

  def self.calc_covariance(data0, data1)
    ave0 = Tefil::Statistics.calc_average(data0)
    ave1 = Tefil::Statistics.calc_average(data1)

    tmp_sum = 0.0
    data0.size.times do |i|
      tmp_sum += (data0[i] - ave0) * (data1[i] - ave1)
    end
    result = tmp_sum / data0.size
  end

  def self.calc_correlation_coefficient(data0, data1)
    sd0 = Tefil::Statistics.calc_standard_deviation(data0)
    sd1 = Tefil::Statistics.calc_standard_deviation(data1)
    cov =self.calc_covariance(data0, data1)
    cov / (sd0 * sd1)
  end

  def process_stream(in_io, out_io)
    matrix = in_io.readlines.map{|line| line.strip.split(/\s+/).map{|str| str.to_f}}

    data = matrix.transpose

    out_io.printf(
      "correlation coefficient : %f\n",
      self.class.calc_correlation_coefficient( data[0], data[1])
    )

    t_mat = matrix.transpose
    data_pairs = [t_mat[0], t_mat[1]].transpose
    #pp data_pairs
    c0, c1 = Malge::LeastSquare.least_square_1st_degree(data_pairs)

    out_io.printf(
      "least square 1st degree : y = a1 x + a0, a1 = %f, a0 = %f\n",
       c1, c0
    )
    


  end

  private

  #def calc_sum(data)
  #  result = 0.0
  #  data.each { |datum| result += datum }
  #  result
  #end

  #def calc_average(data, sum: nil)
  #  sum ||= calc_sum(data) 
  #  sum / data.size.to_f
  #end

  #def calc_variance(data, average: nil)
  #  average ||= calc_average(data)
  #  tmp = 0.0
  #  data.each { |datum| tmp += (datum - average)**2 }
  #  tmp / data.size.to_f
  #end

  #def calc_standard_deviation(data, variance: nil)
  #  variance ||= calc_variance(data)
  #  Math::sqrt(variance)
  #end

end


