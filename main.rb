require 'sinatra'
require 'haml'
#require 'extralite'
require_relative 'db'

set :haml, format: :html5

get '/' do 
  haml :index, :locals=>{:shortened_url => ""}
end

post '/' do
  shortened_url = Db::short params["url"].gsub("http://","").gsub("https://","")
  haml :index, :locals => {:shortened_url => "/#{shortened_url}"}
end

get '/:url' do
  #haml "%h1 #{params[:url]}"
  url = Db.unshort params[:url]
  redirect "https://#{url}"
end
