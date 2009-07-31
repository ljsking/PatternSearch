require 'ptxt'
require 'sentence'
require 'tagger'

class PTxt_Parser
  def initialize(pos_tagger)
    @tagger = pos_tagger
  end
  def parse(file)
    ptxt = PTxt.new
    counter = 1
    begin
    	file = File.new(file, "r")
    	while (line = file.gets)
    	  if line[0..-3] == '<c>'
    		  korean = file.gets[0..-3]
    		  #english = []
    		  while ((line = file.gets)[0..-3]!='</c>')
    		    english=line[0..-3]
  		    end
  		    pattern = @tagger.tag(english)
  		    stnc = Sentence.new(korean, english, pattern)
  		    ptxt.add(stnc)
  		    counter = counter+1
  		  end
    	end
    	file.close
    rescue => err
    	puts "Exception: #{err}"
    	err
    end
    return ptxt, counter
  end
end

