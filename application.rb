# main server file
require 'sinatra'
require './database.rb'
require './bitcoin.rb'

get '/' do
  erb :"index.html"
end

get '/admin' do
  erb :"admin.html"
end
