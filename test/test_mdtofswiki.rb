#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "stringio"

class Tefil::MdToFswiki
  public :process_stream, :process_string
end

class TC_MdToFswiki < Test::Unit::TestCase
  def setup
    @f00 = Tefil::MdToFswiki.new()
  end

  def test_process_stream

    assert_equal("!!! head1"          , @f00.process_string(  "# head1"            ))
    assert_equal("!! head2"           , @f00.process_string(  "## head2"           ))
    assert_equal("! head3"            , @f00.process_string(  "### head3"          ))
    assert_equal("abc ''italic'' def" , @f00.process_string(  "abc *italic* def"   ))
    assert_equal("* item"             , @f00.process_string(  "* item"             ))
    assert_equal("** item"            , @f00.process_string(  "  * item"           ))
    assert_equal("*** item"           , @f00.process_string(  "    * item"         ))
    assert_equal("**** item"          , @f00.process_string(  "      * item"       ))
    assert_equal("+ enum"             , @f00.process_string(  "0. enum"            ))
    assert_equal("++ enum"            , @f00.process_string(  "  0. enum"          ))
    assert_equal("+++ enum"           , @f00.process_string(  "    0. enum"        ))
    assert_equal("++++ enum"          , @f00.process_string(  "      0. enum"      ))

    assert_equal("64 str"            , @f00.process_string(  "64 str"          ))

    assert_equal(" formatted text"    , @f00.process_string(  "    formatted text" ))
    assert_equal("----"               , @f00.process_string(  "---"                ))
    assert_equal("[Google|http://www.google.co.jp/]", @f00.process_string(  "[Google](http://www.google.co.jp/)"))

      #[ "abc **bold** def"                  , "abc '''bold''' def"                ],
      #[                                     , "abc ==strike== def"               ],
      #[                                     , "abc __underline__ def"            ],
      #[                                     , '"" quotation'                     ],
      #[                                     , "*http://www.yahoo.co.jp/"         ],



    #[
    #  [ "# head1"                           , "!!! head1"                         ],
    #  [ "## head2"                          , "!! head2"                          ],
    #  [ "### head3"                         , "! head3"                           ],
    #  [ "abc *italic* def"                  , "abc ''italic'' def"                ],
    #  #[ "abc **bold** def"                  , "abc '''bold''' def"                ],
    #  #[                                     , "abc ==strike== def"               ],
    #  #[                                     , "abc __underline__ def"            ],
    #  #[                                     , '"" quotation'                     ],
    #  [ "* item"                            , "* item"                            ],
    #  [ "  * item"                          , "** item"                           ],
    #  [ "    * item"                        , "*** item"                          ],
    #  [ "      * item"                      , "**** item"                         ],
    #  [ "0. enum"                           , "+ enum"                            ],
    #  [ "  0. enum"                         , "++ enum"                           ],
    #  [ "    0. enum"                       , "+++ enum"                          ],
    #  [ "      0. enum"                     , "++++ enum"                         ],
    #  #[                                     , "*http://www.yahoo.co.jp/"         ],
    #  [ "[Google](http://www.google.co.jp/)", "[Google|http://www.google.co.jp/]" ],
    #  [ "    formatted text"                , " formatted text"                   ],
    #  [ "---"                               , "----"                              ],
    #  #[ "<!-- comment-->"                   , "// comment"                        ],
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
