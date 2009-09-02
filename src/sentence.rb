require 'rubygems'
require 'tree'

class Sentence
  attr_accessor :english, :korean, :document
  def initialize(kor, eng, tree, document=nil)
    @english=eng
    @korean=kor
    @treebank=TreeBank.new(tree)
    @document=document
  end
  def patterns
    return @treebank.patterns
  end
  def make_pattern
    return @treebank.make_pattern
  end
  
  #VB - Verb, base form
  #VBD - Verb, past tense
  #VBG - Verb, gerund or present participle
  #VBN - Verb, past participle
  #VBP - Verb, non-3rd person singular present
  #VBZ - Verb, 3rd person singular present
  def verbs
    verb_forms = ['VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ']
    verbs = []
    pattern_array = make_pattern.split('_')
    word_array = @english.split(' ')
    index = 0
    pattern_array.each do |pattern|
      verbs<<word_array[index] if verb_forms.include?(pattern)
      index+=1
    end
    return verbs
  end
end