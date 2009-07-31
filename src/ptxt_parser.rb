require 'ptxt'
require 'sentence'
require 'tagger'
require 'iconv'

class PTxt_Parser
  def initialize
    @tagger = Tagger.new
    @conv = Iconv.new('utf-8','euc-kr') #euc-kr => utf-8
  end
  def remove_uglycode(sentence)
    ugly_codes = [142, 161, 166, 170]
    ugly_codes.each do |code|
      sentence = sentence.gsub(code.chr,'')
    end
    return sentence
  end
  def parse(file)
    ptxt = PTxt.new
    counter = 1
    begin
    	file = File.new(file, "r")
    	while (line = file.gets)
    	  if line[0..-3] == '<c>'
    		  euc_kr_korean = file.gets[0..-3] #remove \r\n
    		  korean=@conv.iconv(euc_kr_korean)
    		  #english = []
    		  while ((line = file.gets)[0..-3]!='</c>')
    		    english=line[0..-3] #remove \r\n
  		    end
  		    english=remove_uglycode(english)
  		    #puts "tag with #{english}"
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

