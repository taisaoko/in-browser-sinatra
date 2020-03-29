class UsersController < ApplicationController
  
  # what routes do I need for login?
  
  # the purpose of this route is to render the login page (form)
  get '/login' do
    erb :login
  end
  
  # the purpose of this route is to receive the login form
  # find the user, and log the user in (create a sesson)
  post '/login' do
    # params looks like: {email: "user@user.com", password: "password"}
    # Find the user
    @user = User.find_by(email: params[:email])
    # Authenticate the user - verify the user is who they say they are
    # they have the credentials - email/password combo
    # undefined method "authenticate" for nil:Nilclass (@user has a value of nil)
    if @user.authenticate(params[:password])
      # log the user in - create the user session
      session[:user_id] = @user.id #actually loggin the user in
      # redirect to user's show page in this case
      puts session
      redirect "/users/#{@user.id}"
    
    else
      # tell the user they entered invalid credentials
      # redirect them to the login page
    end
  end
  # what routes do I need for signup?
  get '/signup' do
    erb :signup
  end
  
  # user SHOW route
  get'/users/:id' do
    "this will be the user show route"
  end
end