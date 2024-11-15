require 'sinatra'
require 'haml'
#require 'extralite'
require_relative 'db'


class App < Sinatra::Base
  set :haml, format: :html5

  @@shortened_url = "dhdjjd"

  get '/' do 
#    puts @@shortened_url
    haml :index, :locals=>{:shortened_url => @@shortened_url}
  end

  post '/' do
    @@shortened_url = Db::short params["url"].gsub("http://","").gsub("https://","")
    redirect "/"
  end

  get '/:url' do
    #haml "%h1 #{params[:url]}"
    url = Db.unshort params[:url]
    redirect "https://#{url}"
  end
end

App.run! if __FILE__ == $0
