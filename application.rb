# main server file
require 'sinatra'

get '/' do
end

get '/admin' do
  erb :"admin.html.erb"
end
