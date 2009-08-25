require 'test/unit'
require 'src/tagger'
require 'src/sentence'

class TreeBankTest < Test::Unit::TestCase
  @@tagger = Tagger.new
  def test_get_leafnode
    english = 'Ate and eight are homophones .'
    tree = @@tagger.tag(english)
    stc = Sentence.new('', english, tree)
    assert_equal 'CD_CC_CD_VBP_JJ_.', stc.make_pattern
  end
  def test_split_sentences
    english = 'I think it looks fabulous. I love your hair like that.'
    englishs = @@tagger.split(english)
    assert_equal(2, englishs.size)
    assert_equal('I think it looks fabulous .', englishs[0])
    assert_equal('I love your hair like that .', englishs[1])
    
    english = 'Ate and eight are homophones.'
    englishs = @@tagger.split(english)
    assert_equal(1, englishs.size)
    assert_equal('Ate and eight are homophones .', englishs[0])
  end
  
end