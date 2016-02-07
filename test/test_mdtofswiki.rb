#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::MdToFswiki
  public :process_stream
end

class TC_MdToFswiki < Test::Unit::TestCase
  def setup
    @f00 = Tefil::MdToFswiki.new()
  end

  def test_process_stream
    pp "##aho".sub!(/^\#\#\#/  , '')
    exit

    [
      [ "# head1"                           , "!!! head1"                         ],
      [ "## head2"                          , "!! head2"                          ],
      [ "### head3"                         , "! head3"                           ],
      [ "abc *italic* def"                  , "abc ''italic'' def"                ],
      #[ "abc **bold** def"                  , "abc '''bold''' def"                ],
      #[                                     , "abc ==strike== def"               ],
      #[                                     , "abc __underline__ def"            ],
      #[                                     , '"" quotation'                     ],
      [ "* item"                            , "* item"                            ],
      [ "  * item"                          , "** item"                           ],
      [ "    * item"                        , "*** item"                          ],
      [ "      * item"                      , "**** item"                         ],
      [ "0. enum"                           , "+ enum"                            ],
      [ "  0. enum"                         , "++ enum"                           ],
      [ "    0. enum"                       , "+++ enum"                          ],
      [ "      0. enum"                     , "++++ enum"                         ],
      #[                                     , "*http://www.yahoo.co.jp/"         ],
      [ "[Google](http://www.google.co.jp/)", "[Google|http://www.google.co.jp/]" ],
      [ "    formatted text"                , " formatted text"                   ],
      [ "---"                               , "----"                              ],
      [ "<!-- comment-->"                   , "// comment"                        ],
    ].each do |i|
      $stdin = StringIO.new
      $stdin.puts i[0]
      $stdin.rewind
      str = capture_stdout{}
      result = capture_stdout{ @f00.filter([])}
      correct = sprintf("#{i[1]}\n")
      assert_equal(correct, result)
    end
  end
end
