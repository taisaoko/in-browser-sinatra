require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_awesome_journal_app"
  end

  get "/" do
    erb :welcome
  end
  
  helpers do
  
    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user 
      # take a value, turn it into a boolean reflection of its truthiness of an object (nil & false are falsey)
    end
    
    def current_user
      # memoization by an instant variable 
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end
