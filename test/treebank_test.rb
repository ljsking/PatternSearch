require 'test/unit'
require '../src/tagger'
require '../src/sentence'

class TreeBankTest < Test::Unit::TestCase
  def test_get_leafnode
    tagger = Tagger.new
    english = 'Ate and eight are homophones.'
    tree = tagger.tag(english)
    stc = Sentence.new('', english, tree)
    assert_equal 'CD|CC|CD|VBP|JJ|.', stc.pattern
  end
end