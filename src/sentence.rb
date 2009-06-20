class Sentence
  attr_accessor :english, :korean
  def initialize(kor, eng)
    @english=eng
    @korean=kor
  end
end