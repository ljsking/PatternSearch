require 'rubygems'
require 'test/unit'
require 'src/tagger'
require 'src/sentence'
require 'tree'

class SerializeTest < Test::Unit::TestCase
  def test_marshal
    tagger = Tagger.new
    english = 'Ate and eight are homophones.'
    korean = 'Ate와 eight는 동음이의어이다.'
    tree = tagger.tag(english)
    
    stc = Sentence.new(korean, english, tree)
    
    data = Marshal.dump(stc)
    new_stc = Marshal.load(data)
    assert_equal 'CD_CC_CD_VBP_JJ_.', new_stc.make_pattern
  end
end