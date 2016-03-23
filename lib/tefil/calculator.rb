#! /usr/bin/env ruby
# coding: utf-8

require 'pp'



class Tefil::Calculator < Tefil::TextFilterBase
  def initialize(options = {})
    @preserve = true if options[:preserve]
    super(options)
  end

  def process_stream(in_io, out_io)
    in_io.each do |line|
      #method = :sub
      #method = :gsub if @global
      #out_io.puts line.send(method, @old_str, @new_str)
      eq = line.chomp
      #pp eq

      eq.gsub!(/\{/, '\(' )
      eq.gsub!(/\}/, '\)' )
      eq.gsub!(/\\times/, '\*' )
      #if /\frac\{(.*)\}\{(.*)\}/ =~ eq
      #  eq. if /\frac\{(.*)\}\{(.*)\}/ =~ eq
      #end
      #pp eq

      result = `echo  #{eq} | bc -l`.chomp
      result.sub!(/^\./, '0.')
      result.sub!(/^-\./, '-0.')
      result.sub!(/^0$/, '0.0')

      out_io.print line.chomp + " = " if @preserve
      out_io.puts result
    end
  end
end

