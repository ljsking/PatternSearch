class Sentence
  attr_accessor :english, :korean, :pattern
  def initialize(kor, eng, pattern)
    @english=eng
    @korean=kor
    @pattern=pattern
  end
end