
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Directs to a form
  get '/articles/new' do
    erb :new
  end

  # Gets called when user clicks "SUBMIT" from #get(/articles/new)
  post '/articles' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  # Displays all
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # Displays specific article
  get '/articles/:id' do
    get_article
    erb :show
  end

  # Displays form with object attributes filled in
  get '/articles/:id/edit' do
    get_article
    erb :edit
  end

  # Updates existing article with new input
  patch '/articles/:id' do
    get_article.update(title: params[:title], content: params[:content])
    redirect "articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    get_article.delete
    redirect "/articles"
  end

  def get_article
    @article = Article.find(params[:id])
  end

end
