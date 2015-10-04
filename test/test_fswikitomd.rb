#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::FswikiToMd
  public :process_stream
end

class TC_FswikiToMd < Test::Unit::TestCase
  def setup
    @f00 = Tefil::FswikiToMd.new()
  end

  def test_process_stream
    [
      ["!!! head1"                         , "# head1"                            ],
      ["!! head2"                          , "## head2"                           ],
      ["! head3"                           , "### head3"                          ],
      ["abc ''italic'' def"                , "abc *italic* def"                   ],
      ["abc '''bold''' def"                , "abc **bold** def"                   ],
      #["abc ==strike== def"               ,                                      ],
      #["abc __underline__ def"            ,                                      ],
      #['"" quotation'                     ,                                      ],
      ["* item"                            , "* item"                             ],
      ["** item"                           , "  * item"                           ],
      ["*** item"                          , "    * item"                         ],
      ["**** item"                         , "      * item"                       ],
      ["+ enum"                            , "0. enum"                            ],
      ["++ enum"                           , "  0. enum"                          ],
      ["+++ enum"                          , "    0. enum"                        ],
      ["++++ enum"                         , "      0. enum"                      ],
      #["*http://www.yahoo.co.jp/"         ,                                      ],
      ["[Google|http://www.google.co.jp/]" , "[Google](http://www.google.co.jp/)" ],
      [" formatted text"                   , "    formatted text"                 ],
      ["----"                              , "---"                                ],
      ["// comment"                        , "<!-- comment-->"                    ],
    ].each do |i|
      $stdin = StringIO.new
      $stdin.puts i[0]
      $stdin.rewind
      str = capture_stdout{}
      result = capture_stdout{ @f00.filter([])}
      correct = sprintf("#{i[1]}\n")
      assert_equal(correct, result)
    end

    ## stdin -> stdout
    #$stdin = StringIO.new
    #$stdin.puts "!!! head1"
    #$stdin.puts "!! head2"
    #$stdin.puts "! head3"
    #$stdin.puts "abc ''italic'' def"
    #$stdin.puts "abc '''bold''' def"
    ##$stdin.puts "abc ==strike== def"
    ##$stdin.puts "abc __underline__ def"
    ##$stdin.puts '"" quotation'
    #$stdin.puts "* item"
    #$stdin.puts "** item"
    #$stdin.puts "*** item"
    #$stdin.puts "**** item"
    #$stdin.puts "+ enum"
    #$stdin.puts "++ enum"
    #$stdin.puts "+++ enum"
    #$stdin.puts "++++ enum"
    ##$stdin.puts "*http://www.yahoo.co.jp/"
    #$stdin.puts "[Google|http://www.google.co.jp/]"
    #$stdin.puts " formatted text"
    #$stdin.puts "----" #horizontal line
    ##$stdin.puts "abc // commented out"
    #$stdin.rewind
    #str = capture_stdout{}
    #result = capture_stdout{ @f00.filter([])}
    #correct = [
    #  "# head1",
    #  "## head2",
    #  "### head3",
    #  "abc *italic* def",
    #  "abc **bold** def",
    #  "* item",
    #  "  * item",
    #  "    * item",
    #  "      * item",
    #  "0. enum",
    #  "  0. enum",
    #  "    0. enum",
    #  "      0. enum",
    #  "[Google](http://www.google.co.jp/)",
    #  "    formatted text",
    #  "---",
    #  ""
    #].join("\n")
    #assert_equal(correct, result)
  end
end







