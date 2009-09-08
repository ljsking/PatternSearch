require 'rubygems'
require 'sinatra'
require 'haml'

get '/find' do
  "Hello World"
end

get '/search' do
  @query = params[:query]
  @query = ''  if @query == nil
  #puts @query
  @results = []
  (1..10).each { |i| @results<<i.to_s+" "+@query } unless @query==''
  haml :search
end

get '/stylesheet.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end