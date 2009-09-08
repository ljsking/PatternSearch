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