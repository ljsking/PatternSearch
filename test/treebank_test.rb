require 'test/unit'
require '../src/tagger'

class TreeBankTest < Test::Unit::TestCase
  def test_get_leafnode
    tagger = Tagger.new
    assert_equal 'CD|CC|CD|VBP|JJ', tagger.tag('Ate and eight are homophones.')
  end
end