require "sinatra"
require "pry"
require "warden"
require "mongoid"
# require "./env.rb"

include Mongo
# binding.pry


use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => '$uper_$3cr37_K3y'
# binding.pry
Mongoid.load!("./mongoid.yml", :production)


# class YourApp < Sinatra::Application
	# Warden Configuration
	use Warden::Manager do |manager|
		manager.default_strategies :password
		manager.failure_app = YourApp
		# binding.pry
		# manager.serialize_into_session(:current_user) {|user| user.id}
		# binding.pry
		# Warden::Manager.serialize_into_session do |user|
		# 	binding.pry
		#   	user.id
		# end
		# manager.serialize_from_session(:current_user) {|id| User.find_by(:user).find_by_id(id)}
	end
	 
	Warden::Manager.before_failure do |env,opts|
	  	env['REQUEST_METHOD'] = 'POST'
	end
	 
	Warden::Strategies.add(:password) do
		def authenticate!
			# binding.pry
			# User.first(conditions: {username: user[email]})
		  	begin
		  		user = User.find_by(email: params["user"]["email"])
		  		decrypt_password = BCrypt::Password.new(user.password)
		  		password = params["user"]["password"]
		  		# binding.pry
		  		if user && decrypt_password == password
		    		success!(user)
		  		end
		  	rescue Exception => e
		  		# binding.pry
		  		fail!("Could not log in")
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
	    redirect '/login' unless user_authenticated?
	end

        def user_authenticated?
           warden_handler.authenticated?
        end
# end