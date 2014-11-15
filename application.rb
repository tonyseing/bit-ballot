# main server file
require 'sinatra'
require './database.rb'
require './bitcoin.rb'
require './auth.rb'

get '/' do
  erb :"index.html"
end

get '/admin' do
  check_authentication
  erb :"admin.html"
end
