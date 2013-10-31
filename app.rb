require "rubygems"
require "sinatra"
require "erb"
require "pry"
require "./CvsHelper"

configure do
	enable :sessions
	set :session_secret, ENV['SESSION_SECRET'] ||= "Napoleon_top_secret_Austin"
	
end


get '/' do
	@title = "home"
	if session[:userIndex] == nil
		puts "I see nill"
		session[:userIndex] = 0
		session[:tableSelectedIndex] = 0
		session[:totalColumn] = 0
		@user_Hash = Hash.new
		
	end
	erb :index
end

post '/thanks' do
	@title = "thanks"
	#add params to the session
	session[:name] = params['name']	
	session[:email] = params['email']
	session[:twitter] = params['twitter']
	puts "Hash equals = #{@user_Hash}"	
	
	#add current user input to the hash

	@keyName = "name#{session[:userIndex]}"
	@keyEmail = "email#{session[:userIndex]}"
	@keytwitter = "twitter#{session[:userIndex]}"
	
	
	@user_Hash = { @keyName => session[:name],@keyEmail => session[:email], @keytwitter => session[:twitter]}
	@keyVisitor = "visitor#{session[:userIndex]}"
	
	session[:@keyVisitor] = @user_Hash
	session[:userIndex] = session[:userIndex] + 1
	#part 4 start here
	@fileName = "demoFile.cvs"
	csv_File = CvsHelper.new
	if csv_File.is_Exist(@fileName)
		csv_File.append_content(@fileName,@user_Hash)
	else
		puts "File does not exist"
		csv_File.create_content(@fileName,@user_Hash)
	end
	 
	erb :thanks
end
get '/suckers' do
	@user_index = -1
	@title = "suckers"
	
	@fileName = "demoFile.cvs"
	csv_File = CvsHelper.new
	if csv_File.is_Exist(@fileName)
		@Array_Of_Inputs = 	csv_File.get_Array_of_Hashes(@fileName)
		erb :suckers	
	else
		puts "File does not exist"
		"File Does not exist"
	end	
end

get '/suckers/:userIndex' do
	@user_index = params[:userIndex]
	@title = "sucker #{@user_index}"
	
	@fileName = "demoFile.cvs"
		csv_File = CvsHelper.new
		if csv_File.is_Exist(@fileName)
			@Array_Of_Inputs = 	csv_File.get_Array_of_Hashes(@fileName)
			erb :suckers	
		else
			puts "File does not exist"
			"File Does not exist"
		end
end

get '/clear' do
	session.clear
	redirect '/'
end