class JournalEntriesController < ApplicationController
  
  # get journal_entries/new to render a form to create new entry
  get '/journal_entries/new' do
    erb :'/journal_entries/new'
  end
  
  # post journal_entries to create a new journal entry
  post '/journal_entries' do
    # raise params.inspect
    # I want to create a new journal entry and save it to the debugger
    # I also only want to create a journal entry if a user is logged in
    if !logged_in?
      redirect '/'
    end
    # I only want to save the entry if it has some content
    if params[:content] != ""
      # create a new entry
      @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
      redirect '/journal_entries/#{@journal_entry.id}'
    else
      redirect '/journal_entries/new'
    end
  end
  
  # show route for a journal entry
  get '/journal_entries/:id' do
    @journal_entry = JournalEntry.find(params[:id])
    erb :'>journal_entries/show'
  end
  
  # This route should send us to journal_entries/edit.erb, which will render an edit form
  get '/journal_entries/:id/edit' do
    erb :'/journal_entries/edit'
  end
  # index route for all journal entries
  
end