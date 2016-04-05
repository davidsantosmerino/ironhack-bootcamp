require "sinatra"
require "sinatra/reloader"
require "artii"

get "/" do
  erb(:welcome)
end

get "/ascii/:word/?:font?/?:secret?" do
  word = params[:word]
  font = params[:font] ? params[:font] : "slant"
  secret = params[:secret]
  if font == "special" && secret == "secret"
    erb(:secret_unicorn)
  else
    artii = Artii::Base.new :font => font
    @word_ascii = artii.asciify word
    erb(:ascii)
  end
end
