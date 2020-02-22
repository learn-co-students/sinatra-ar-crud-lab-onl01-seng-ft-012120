
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do 
    erb :new
  end

  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end

  patch '/articles/:id' do 
    Article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{params[:id]}"
  end

  delete '/articles/:id' do 
    @article = Article.find_by_id(params[:id])
    @article.destroy if @article
    redirect '/articles'
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])

    erb :edit
  end

  post '/articles' do 
    article = Article.create(title: params[:title], content: params[:content])
    id = article[:id]
    redirect "/articles/#{id}"
  end

  get '/articles' do 
    @articles = Article.all
    erb :index
  end
end
