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
    @user.authenticate(params[:password])
    # log the user in
    # Redirect to user's landing page (show? index? dashboard?)
  end
  # what routes do I need for signup?
  get '/signup' do
    erb :signup
  end
  
end