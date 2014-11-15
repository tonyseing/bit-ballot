require "sinatra"
require "pry"
require "warden"
require "mongoid"

enable :session
Mongoid.load!("./db.yml", :development)



# Warden Configuration
use Warden::Manager do |manager|
	manager.default_strategies :password
	manager.failure_app = Sinatra::Application
end
 
Warden::Manager.before_failure do |env,opts|
  	env['REQUEST_METHOD'] = 'POST'
end
 
Warden::Strategies.add(:password) do
	def authenticate!
		# binding.pry
		user = session[:user]
	  	begin
	  		organizer = Organizer.where(email: user["email"]).first
	  		# decrypt_password = BCrypt::Password.new(organizer.password)
	  		password = user[:password]
	  		
	  		if organizer && decrypt_password == password
	    		success!(organizer)
	    	else
	    		fail!
	  		end
	  	rescue Exception => e
	  		binding.pry
	  		
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
    redirect URI.encode('?login_error=Organizer\'s credentials needed') + '#login' unless user_authenticated?
end

def user_authenticated?
   warden_handler.authenticated?
end

post '/login' do
	session[:user] = params[:user]
	warden_handler.authenticate!
	if warden_handler.authenticated?
		session[:user] = session["warden.user.default.key"]
		redirect "/admin" 
	end
end 

post "/unauthenticated" do
    redirect URI.encode("?login_error=Email or password is incorrect, please try again") + "#login"
end