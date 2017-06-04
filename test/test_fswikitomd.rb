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
    #a = StringIO.open( "abc\nABC\n")
    #pp a.readlines

    #exit

    in_io = StringIO.open("!!! head1\n")
    out_io = StringIO.new
    @f00.process_stream(in_io, out_io)
    out_io.rewind
    assert_equal("# head1\n\n", out_io.read)

    in_io = StringIO.open("!!! head2\n")
    out_io = StringIO.new
    @f00.process_stream(in_io, out_io)
    out_io.rewind
    assert_equal("# head2\n\n", out_io.read)

    exit
    #
    input = <<HERE
!!! head1
!! head2
! head3
abc ''italic'' def
abc '''bold''' def
* item
** item
*** item
**** item
+ enum
++ enum
+++ enum
++++ enum
[Google|http://www.google.co.jp/]" ,
 formatted text"
----"
// comment"
HERE

#abc ==strike== def
#abc __underline__ def
#"" quotation'
#*http://www.yahoo.co.jp/"

    correct = <<HERE
# head1

# head1

## head2

### head3

abc *italic* def
abc **bold** def

* item
    * item
        * item
            * item
1. enum
    1. enum
        1. enum
            1. enum

[Google](http://www.google.co.jp/)
    formatted text
---
<!-- comment-->
HERE


      in_io = StringIO.new
      in_io.puts input
      in_io.rewind
      out_io = StringIO.new
      @f00.process_stream(in_io, out_io)
      out_io.rewind
      result = out_io.read

      assert_equal(correct, result)
    #end

    #[
    #  ["!!! head1"                         , "# head1"                            ],
    #  ["!! head2"                          , "## head2"                           ],
    #  ["! head3"                           , "### head3"                          ],
    #  ["abc ''italic'' def"                , "abc *italic* def"                   ],
    #  ["abc '''bold''' def"                , "abc **bold** def"                   ],
    #  #["abc ==strike== def"               ,                                      ],
    #  #["abc __underline__ def"            ,                                      ],
    #  #['"" quotation'                     ,                                      ],
    #  ["* item"                            , "* item"                             ],
    #  ["** item"                           , "    * item"                           ],
    #  ["*** item"                          , "        * item"                         ],
    #  ["**** item"                         , "            * item"                       ],
    #  ["+ enum"                            , "1. enum"                            ],
    #  ["++ enum"                           , "    1. enum"                          ],
    #  ["+++ enum"                          , "        1. enum"                        ],
    #  ["++++ enum"                         , "            1. enum"                      ],
    #  #["*http://www.yahoo.co.jp/"         ,                                      ],
    #  ["[Google|http://www.google.co.jp/]" , "[Google](http://www.google.co.jp/)" ],
    #  [" formatted text"                   , "    formatted text"                 ],
    #  ["----"                              , "---"                                ],
    #  ["// comment"                        , "<!-- comment-->"                    ],
    #].each do |i|
    #  $stdin = StringIO.new
    #  $stdin.puts i[0]
    #  $stdin.rewind
    #  #str = capture_stdout{}
    #  result = capture_stdout{ @f00.filter([])}
    #  correct = sprintf("#{i[1]}\n")
    #  assert_equal(correct, result)
    #end




  end
end
