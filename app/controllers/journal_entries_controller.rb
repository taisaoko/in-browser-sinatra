class JournalEntriesController < ApplicationController
  
  # index route for all journal entries
  get '/journal_entries' do
    @journal_entries = JournalEntry.all
    erb :'journal_entries/index'
  end
  
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
      flash[:message] = "Journal entry sucessfully created."
      @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
      redirect '/journal_entries/#{@journal_entry.id}'
    else
      flash[:message] = "Something went wrong." # should not be before a render (erb) only before a redirect since flash messages only last 1 HTTP request.  
      redirect '/journal_entries/new'
    end
  end
  
  # show route for a journal entry
  get '/journal_entries/:id' do
    set_journal_entry
    erb :'journal_entries/show'
  end
  
  # *** MAJOR PROBLEMS!!! ***
  # RIGHT NOW, ANYONE CAN EDIT ANYONE ELSE'S JOURNAL entries
  # ALSO, I CAN EDIT A JOURNAL ENTRY TO BE BLANK!
  # This route should send us to journal_entries/edit.erb, which will render an edit form
  get '/journal_entries/:id/edit' do
    set_journal_entry
    if logged_in?
      if authorized_to_edit?(@journal_entry)
        erb :'/journal_entries/edit'
      else
        redirect "users/#{current_user.id}"
      end
    else
      redirect'/'
    end
  end
  
  # This action's job is to 
  patch '/journal_entries/:id' do
    # 1.find the journal entry
    set_journal_entry
    if logged_in?
      if authorized_to_edit?(@journal_entry)&& params[:content] != ""
      # 2.update the journal entry
        @journal_entry.update(content: params[:content])
        # 3.redirect to show page
        redirect "/journal_entries/#{@journal_entry.id}"
        else
        redirect "users/#{current_user.id}"
      end
    else
      redirect'/'
    end
  end
  
  delete '/journal_entries/:id' do
    set_journal_entry
    if authorized_to_edit?(@journal_entry)
      @journal_entry.destroy # destroy runs callbacks on the models while delete doesn't
      redirect '/journal_entries' # separation of concerns, usually render erb in get requests.
    else
      redirect '/journal_entries'
    end
  end
  
  private # only call inside of this class
  
  def set_journal_entry
    # this is a helper method
    @journal_entry = JournalEntry.find(params[:id])
  end
end