
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get "/articles" do 
    @articles = Article.all
    erb :index
  end

  get "/articles/new" do
    erb :new
  end
  
  get "/articles/:id" do 
    @article = Article.find(params[:id])

    erb :show
  end

  post "/articles" do
    articles = Article.create(params)
    redirect to "articles/#{articles.id}"
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch "/articles/:id" do 
    new_hash = {}
    new_hash[:title] = params[:title]
    new_hash[:content] = params[:content]
    @article = Article.find(params[:id])
    @article.update(new_hash)
    redirect to "articles/#{@article.id}"
  end

  delete "/articles/:id" do
    @article = Article.find(params[:id])
    @article.destroy
    redirect to "articles"
  end

end
