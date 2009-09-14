require 'rubygems'
require 'sinatra'
require 'haml'
require 'Sass'
require 'search'

@@search = Search.new

get '/' do
  redirect("/search")
end

get '/search' do
  @query = params[:query]
  @query='' if @query==nil
  @hits = []
  start_time = Time.now
  @hits=@@search.search(@query) unless @query == ''
  @elapsed_time=Time.now-start_time
  haml :search
end

get '/stylesheet.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end

