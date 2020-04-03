class JournalEntriesController < ApplicationController
  
  # get journal_entries/new to render a form to create new entry
  get '/journal_entries/new' do
    erb :'/journal_entries/new'
  end
  # post journal_entries to create a new journal entry
  post '/journal_entries' do
    raise params.inspect
    # I want to create a new journal entry and save it to the debugger
    # I also only want to create a journal entry if a user is logged in
    if !logged_in
      redirect '/'
    end
    # I only want to save the entry if it has some content
    if params[:content] != ""
      # create a new entry
      @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
    else
      redirect '/journal_entries/new'
    end
  end
  # show route for a journal entry
  
  # index route for all journal entries
end