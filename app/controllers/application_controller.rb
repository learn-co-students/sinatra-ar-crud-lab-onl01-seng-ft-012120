
require_relative '../../config/environment'
require 'pry'

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
        @articles = Article.all.find(params["id"])
        erb :show

      end

      post '/articles/:id' do
      @article = Article.create(title: params[:title], content: params[:content]).save
        redirect "/articles/#{Article.last.id}"
        erb :show
      end

      get '/articles' do
        @articles = Article.all 
        erb :index
      end

      get '/articles/:id/edit' do
        @article = Article.find(params["id"])
        erb :edit
      end

      patch '/articles/:id' do
        id = params["id"]
        new_params = {}
        old_article = Article.find(id)
        new_params[:title] = params["title"]
        new_params[:content] = params["content"]
        old_article.update(new_params)
        redirect "/articles/#{id}"
        erb :show
      end

     
      

      delete '/articles/:id/delete' do 
        @article = Article.find(params["id"])
        @article.destroy

        erb :delete

      end




 
end
