class PTxt
  attr_accessor :filename
  def initialize
    @sentences = []
  end
  def verify
    return true
  end
  def size
    return @sentences.size
  end
  def add(sentence)
    @sentences << sentence
  end
  def get(idx)
    return @sentences[idx]
  end
end