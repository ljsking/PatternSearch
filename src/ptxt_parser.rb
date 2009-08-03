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
    ugly_codes = [142, 161, 166, 170, 174, 184]
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
    	  if remove_newlines(line)  == '<c>'
    		  euc_kr_korean = remove_newlines(file.gets)
    		  korean=@conv.iconv(euc_kr_korean)
    		  eng_count = 0
    		  while (line = remove_newlines(file.gets))!='</c>'
    		    english=remove_newlines(line)
    		    eng_count+=1
  		    end
  		    raise "eng_count:#{eng_count}" unless eng_count==1
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
  def remove_newlines(line)
    return line.sub(/\r?\n|\r(?!\n)/,'') 
  end
end