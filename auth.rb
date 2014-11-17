require "sinatra"
require "pry"
require "warden"
require "mongoid"
require "bcrypt"

use Rack::Session::Pool, :expire_after => 2592000
set :session_secret, 'youwontguessthisever'
set :sessions, :domain => '/'

Mongoid.load!("./mongoid.yml", :development)

# Warden Configuration
use Warden::Manager do |manager|
	manager.default_strategies :user
	manager.serialize_into_session{|user| user.email }
	manager.serialize_from_session{|email| Organizer.where(email: email).first }
	manager.failure_app = Sinatra::Application
end
 
Warden::Manager.before_failure do |env,opts|
  	env['REQUEST_METHOD'] = 'POST'
end
 
Warden::Strategies.add(:user) do
	def authenticate!
		user = params["user"]
	  	begin
	  		if Organizer.where(email: user["email"]).first.nil?
				throw(:warden, {:error => "User not Found", :location => "login"})
			end

	  		organizer = Organizer.where(email: user["email"]).first
	  		decrypt_password = BCrypt::Password.new(organizer.password)
	  		password = user["password"]

	  		if organizer && decrypt_password == password
	    		success!(organizer)
	    	else
	    		throw(:warden, {:error => "Email or password is incorrect, please try again.", :location => "login"})
	  		end
	  	rescue Exception => e
	  		puts e
	  	end
	end
end

def warden_handler
    env['warden']
end

def current_user
    warden_handler.user
end

# checked authentication for protected pages
def check_authentication
    redirect URI.encode('?login_error=Organizer\'s credentials needed ') + '#login' unless warden_handler.authenticated?
end

post '/login' do
	warden_handler.authenticate!
	redirect "/admin" 
end

post '/signup' do
	user = params[:user]
	errors = []
	if !Organizer.where(email: user["email"]).first.nil?
		redirect URI.encode("?signup_error=>> ERROR: ")+ user[:email] + URI.encode(" already exists << ") + "#signup"
	end

	if user["name"].empty?
		errors << "Name cannot be blank. "
	end

	if user["email"].empty?
		errors << "Email address cannot be blank. "
	end

	if user["password"] != user["verify-password"]
		errors << "Password did not match. "
	end

	if user["password"].empty? or user["verify-password"].empty?
		errors << "Password or Verify Password cannot be blank. "
	end

	if errors.empty?
		organizer 			= Organizer.new
		organizer.name 		= user["name"]
		organizer.email 	= user["email"]
		organizer.password 	= BCrypt::Password.create(user["password"])
		organizer.save!

		# Add user to warden authentication
		warden_handler.authenticate!
		redirect "/admin" 
	else
		es = ""
		errors.each do |e|
			es << e 
		end
		redirect URI.encode("?signup_error=>> ERROR: " + es + " << ") + "#signup"
	end
end

post "/unauthenticated" do
    redirect URI.encode("/?" << env['warden.options'][:"location"] << "_error=>> ERROR: " << env['warden.options'][:"error"] << " << ") + "#" << env['warden.options'][:"location"]
end