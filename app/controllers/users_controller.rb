class UsersController < ApplicationController
  
  # what routes do I need for login?
  
  # the purpose of this route is to render the login page (form)
  get '/login' do
    erb :login
  end
  
  # the purpose of this route is to receive the login form
  # find the user, and log the user in (create a sesson)
  post '/login' do
    binding.pry
  end
  # what routes do I need for signup?
  get '/signup' do
    erb :signup
  end
  
end