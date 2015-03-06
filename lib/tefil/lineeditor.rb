class Tefil::LineEditor < Tefil::TextFilterBase
  def initialize(options = {})
    @sort = options[:sort]
    @random = options[:random]
    super(options)
  end

  def process_stream(in_io, out_io)
    in_io.each do |line|
      if @sort
        out_io.puts line.chomp.split(//).sort.join('')
      end
      if @random
        out_io.puts line.chomp.split(//).sort_by{rand}.join('')
      end
    end
  end
end



