require "rubygems"
require "sinatra"
require "erb"
require "pry"

<<<<<<< HEAD
enable :sessions

get '/' do
	erb :index		
end

post '/' do
	erb :caught
	
end

post '/thanks' do
	erb :thanks => { :name => params[:name] }
=======
configure do
	enable :sessions
end

get '/' do
	erb :index
end

post '/thanks' do
	@name = params[:name]
	session[:value] = {
		"name" => @name
	}
	erb :thanks
>>>>>>> 8df7aef69bfd6ca774837b4fab391e8b5092af1b
end

get '/suckers' do
	erb :suckers
end

get '/suckers/post/:id' do
	@post = find_post (params[:id])
	
	@post
end

post '/clear' do
  session.clear
  redirect '/'
end