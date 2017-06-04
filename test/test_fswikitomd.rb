#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::FswikiToMd
  public :process_stream,
   :process_string
end

class TC_FswikiToMd < Test::Unit::TestCase
  def setup
    @f00 = Tefil::FswikiToMd.new()
  end

  def test_process_string
    assert_equal("# head1\n\n", @f00.process_string("!!! head1\n"))
    assert_equal("# head2\n\n", @f00.process_string("!!! head2\n"))
    assert_equal("# head3\n\n", @f00.process_string("!!! head3\n"))

    assert_equal("abc *italic* def",
                 @f00.process_string("abc ''italic'' def"))
    assert_equal("abc **bold** def",
                 @f00.process_string("abc '''bold''' def"))
    assert_equal( "* item",
                 @f00.process_string("* item"))
    assert_equal("    * item",
                 @f00.process_string("** item"))
    assert_equal("        * item",
                 @f00.process_string("*** item"))
    assert_equal("            * item",
                 @f00.process_string("**** item"))
    assert_equal("1. enum",
                 @f00.process_string("+ enum"))
    assert_equal("    1. enum",
                 @f00.process_string("++ enum"))
    assert_equal("        1. enum",
                 @f00.process_string("+++ enum"))
    assert_equal("            1. enum",
                 @f00.process_string("++++ enum"))
    assert_equal("[Google](http://www.google.co.jp/)",
                 @f00.process_string("[Google|http://www.google.co.jp/]" ))
    assert_equal("    formatted text",
                 @f00.process_string(" formatted text"))
    assert_equal("---",
                 @f00.process_string("----"))
    assert_equal("<!-- comment-->",
                 @f00.process_string("// comment"))
  end

  def test_process_stream
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

#    correct = <<HERE
## head1
#
## head1
#
### head2
#
#### head3
#
#abc *italic* def
#abc **bold** def
#
#* item
#    * item
#        * item
#            * item
#1. enum
#    1. enum
#        1. enum
#            1. enum
#
#[Google](http://www.google.co.jp/)
#    formatted text
#---
#<!-- comment-->
#HERE
#
#
#      in_io = StringIO.new
#      in_io.puts input
#      in_io.rewind
#      out_io = StringIO.new
#      @f00.process_stream(in_io, out_io)
#      out_io.rewind
#      result = out_io.read
#
#      assert_equal(correct, result)
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
