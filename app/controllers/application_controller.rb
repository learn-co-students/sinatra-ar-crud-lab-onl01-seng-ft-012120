
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :'articles/new'
  end

  post '/articles' do
    Article.create(params)
    redirect to "articles/#{Article.last.id}"
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :'articles/show'
  end

  get '/articles/:id/edit' do 
    @article = Article.find_by_id(params[:id])
    erb :'articles/edit'
  end

  patch '/articles' do
    article = Article.find_by_id(params[:id])
    new_info = params.select{|k,v| k == 'title'|| k == 'content'}
    article.update(new_info)
    redirect to "/articles/#{article.id}"
  end

  delete '/articles/:id' do
    article = Article.find_by_id(params[:id])
    article.destroy
    redirect to '/articles'
  end


end
