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
    if @user && @user = User.find_by(email: params[:email])
    # Authenticate the user - verify the user is who they say they are
    # they have the credentials - email/password combo
    # undefined method "authenticate" for nil:Nilclass (@user has a value of nil)
    if @user.authenticate(params[:password])
      # log the user in - create the user session
      session[:user_id] = @user.id # actually logging the user in
      # redirect to user's show page in this case
      puts session
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Your credentials were invalid. Please sign up or try again."
      # tell the user they entered invalid credentials
      # redirect them to the login page
    end
  end
  
  # what routes do I need for signup?
  # this route's job is to render a signup form
  get '/signup' do
    # erb (render a view)
    erb :signup
  end
  
  post '/users' do
    # here is where we create a new user and persist the new user to the DB
    # param will look like this: { "name" => "Elizabeth", "email" => "e@e.com", "password" => 'psw' }
    # I only want to persist a user that has a name, email, and password
    if params[:name] !="" && params[:email] != "" && params[:password] != ""
      # valid input
      @user = User.create(params)
      session[:user_id] = @user.id # actually logging the user in
      # where do I go now?
      # let's go to the user show page
      redirect "/users/#{@user.id}" #interpolate b/c it's a string
    else
      # not valid input
      # it would be better to include a message to the user telling what is wrong
      redirect '/signup'
    end
  end
  
  # user SHOW route
  get '/users/:id' do
    # what do I need to do first?
    # raise params.inspect (show runtime error, the params in hash form {"id"= => "3")
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end
  
  get '/logout' do
    session.clear
    redirect '/'
  end
end