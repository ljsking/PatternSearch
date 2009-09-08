require 'rubygems'
require 'sinatra'
require 'haml'
require 'tagger'
require 'tree_bank'
require 'solr'

@@tagger = Tagger.new
@@conn = Solr::Connection.new('http://localhost:8983/solr')

def search(english)
  rz=@@tagger.split(english)
  english = rz[0]
  words = english.split(" ")
  treebank = TreeBank.new(@@tagger.tag(english))
  patterns = treebank.make_patterns
  sorted = (patterns.sort {|a,b| a[1]<=>b[1]} ).reverse
  
  pattern = sorted[0][0].split("_")
  index = 0
  verbs = []
  verb_forms = ['VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ']
  pattern.each do |symbol|
    verbs<<words[index] if verb_forms.include?(symbol)
    index+=1
  end
  
  qeuries=[]
  puts "Searching #{sorted[0][0]}"
  sorted.each do |item|
    pattern=item[0]
    point=item[1]
    qeuries<<"(patterns:#{pattern})^#{point}" if point>0.1
  end
  
  verbs.each do |verb|
    qeuries<<"verbs:#{verb}"
  end
  response = @@conn.query(qeuries.join(" "))
  return response.hits
end

get '/' do
  redirect("/search")
end

get '/search' do
  @query = params[:query]
  @query='' if @query==nil
  @hits = []
  start_time = Time.now
  @hits=search(@query) unless @query == ''
  @elapsed_time=Time.now-start_time
  haml :search
end

get '/stylesheet.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end