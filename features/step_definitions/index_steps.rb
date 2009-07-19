Given /^I have a Sentence instance with '(.+)' and '(.+)'$/ do |korean, english|
  puts 'eng: '+english
  #parser = StandoffDocumentPreprocessor.new
  #parse =  parser.apply('"Ate" and "eight" are homophones.')
  #parse.children or label or each() {|node| ...}
  #p.children.each(){ |n| puts n.label }
end

When /^I need to index a instance$/ do
  pending
end

Then /^I should see it in indices$/ do
  pending
end