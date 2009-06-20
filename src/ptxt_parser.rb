class PTxt_Parser
  def parse(file)
    ptxt = PTxt.new
    counter = 1
    begin
    	file = File.new(file, "r")
    	while (line = file.gets)
    	  if line[0..-3] == '<c>'
    		  korean = file.gets[0..-3]
    		  english = []
    		  while ((line = file.gets)[0..-3]!='</c>')
    		    english<<line[0..-3]
  		    end
  		    stnc = Sentence.new(korean, english)
  		    ptxt.add(stnc)
  		    counter = counter+1
  		  end
    	end
    	file.close
    rescue => err
    	puts "Exception: #{err}"
    	err
    end
    return ptxt
  end
end

