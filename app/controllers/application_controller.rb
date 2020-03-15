
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do # this is where the form resides
    erb :new
  end

  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}"
  end

  get '/articles' do
    @articles = Article.all.each do |article|
      article
    end
    erb :index
  end

  get '/articles/:id' do
    @article_data = Article.find(params[:id])
    erb :results
  end

  get '/articles/:id/edit' do 
    @article_data = Article.find(params[:id])
    erb :edit
  end
  
  patch '/articles/:id' do
    article = Article.find(params[:id])
    article.update(params[:article])
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
   @article_data = Article.find(params[:id])
   @article_data.destroy
   redirect to '/articles'
  end

end