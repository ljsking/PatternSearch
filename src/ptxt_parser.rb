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
    _sentence = ""
    sentence.each_byte do |c|
      _sentence<<c.chr if c<128
    end
    #puts "before #{sentence} after #{_sentence}"
    return _sentence
  end
  def parse(file_name)
    ptxt = PTxt.new
    counter = 1
  	file = File.new(file_name, "r")
  	linenum = 0
  	while (line = file.gets)
  	  linenum+=1
  	  if remove_newlines(line)  == '<c>'
  		  euc_kr_korean = remove_newlines(file.gets)
  		  linenum+=1
  		  begin
  		    korean=@conv.iconv(euc_kr_korean)
  		  rescue => err
  		    error_msg = "while iconving - #{err} in #{file_name}:#{linenum}"
		      $LOG.error error_msg
		      $stderr.print "\n"+error_msg+"\n"
	      end
  		  orig_englishes = []
  		  while (line = remove_newlines(file.gets))!='</c>'
  		    linenum+=1
  		    orig_englishes<<remove_newlines(line)
		    end
		    orig_englishes.each do |orig_english|
		      orig_english=remove_uglycode(orig_english)
  		    sentences = @tagger.split_by_sentence(orig_english)
  		    
  		    sentences.each do |sentence|
  		      english = sentence.to_s
  		      puts "tag with #{english} with #{english.class}"
  		      pattern = @tagger.tag(english)
    		    stnc = Sentence.new(korean, english, pattern, orig_english)
    		    ptxt.add(stnc)
    		    #$stderr.print '.'
    		    counter = counter+1
  	      end
	      end
		  end
  	end
  	file.close
    return ptxt, counter
  end
  def remove_newlines(line)
    return line.sub(/\r?\n|\r(?!\n)/,'') 
  end
end