require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_awesome_journal_app"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
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
    
    def authorized_to_edit?(journal_entry)
      journal_entry.user == current_user
    end
    
  end

end
