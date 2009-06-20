Given /^I have a ptxt file named (.+)$/ do |file|
  @file = file
end

When /^I need to parse a file$/ do
  @parser = PTxt_Parser.new
  @model = @parser.parse('data/example/'+@file)
end

Then /^I should see a english sentences$/ do
  assert(@model.size>0)
  assert(@model.get(rand(@model.size)).korean != nil)
end

Then /^I should see a korean sentences$/ do
  assert(@model.size>0)
  assert(@model.get(rand(@model.size)).english.size > 0)
  idx = rand(@model.size)
  assert(@model.get(idx).english[rand(@model.get(idx).english.size)] != nil)
end