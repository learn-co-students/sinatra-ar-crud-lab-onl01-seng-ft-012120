
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get "/articles/new" do 
    erb :new
  end

  post "/articles" do 
    @article = Article.create(
      title: params[:title],
      content: params[:content]
    )
    redirect "/articles/#{@article.id}"
  end

  get "/articles" do 
    @articles = Article.all
    erb :index
  end

  get "/articles/:id" do 
      @article = Article.all.select do |article|
        article.id == params[:id].to_i
      end.first
      erb :show
  end

  get "/articles/:id/edit" do
    @article = Article.all.select do |article|
      article.id == params[:id].to_i
    end.first
    erb :edit
  end

  patch "/articles/:id" do
    @article = Article.all.select do |article|
      article.id == params[:id].to_i
    end.first
    @article[:title] = params[:title] 
    @article[:content] = params[:content]
    @article.save
    redirect "/articles/#{@article[:id]}"
  end

  delete "/articles/:id" do 
    @article = Article.find_by_id(params[:id])
    @article.delete
  end

end
