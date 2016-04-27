#! /usr/bin/env ruby
# coding: utf-8

require 'pp'



class Tefil::Calculator < Tefil::TextFilterBase
  def initialize(options = {})
    @options = options
    @preserve = options[:preserve]
    @ruby = options[:ruby]
    super(options)
  end

  def process_stream(in_io, out_io)
    in_io.each do |line|
      eq = line.chomp

      eq.gsub!(/\{/, '(' )
      eq.gsub!(/\}/, ')' )
      eq.gsub!(/\\times/, '*' )

      if @ruby
        eq.gsub!(/\^/, '**' )
        eq.gsub!(/sqrt/, 'Math::sqrt' )
        eq.gsub!(/log\(/, 'Math::log(' )
        eq.gsub!(/l\(/, 'Math::log(' )
        eq.gsub!(/exp\(/, 'Math::exp(' )
        eq.gsub!(/e\(/, 'Math::exp(' )
        result = eval(eq)
      else
        eq.gsub!(/\(/, '\(' )
        eq.gsub!(/\)/, '\)' )
        eq.gsub!(/\*/, '\*' )

        result = `echo  #{eq} | bc -l`.chomp
        result.sub!(/^\./, '0.')
        result.sub!(/^-\./, '-0.')
        result.sub!(/^0$/, '0.0')
      end

      out_io.print line.chomp + " = " if @preserve
      out_io.puts result
    end
  end
end

