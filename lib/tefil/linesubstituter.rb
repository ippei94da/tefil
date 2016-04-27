class Tefil::LineSubstituter < Tefil::TextFilterBase
  def initialize(old_str, new_str, options = {})
    @old_str  = old_str
    @old_str  = /#{old_str}/ if options[:regexp]
    @new_str  = new_str
    @global = options[:global]
    super(options)
  end

  def process_stream(in_io, out_io)
    in_io.each do |line|
      method = :sub
      method = :gsub if @global
      out_io.puts line.send(method, @old_str, @new_str)
    end
  end
end

