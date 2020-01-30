require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    new_title = params[:title]
    new_content = params[:content]
    #binding.pry
    @article = Article.create(title: new_title, content: new_content)
    redirect to "/articles/#{@article.id}"
  end
  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end
  get '/articles' do
    @articles = Article.all
    erb :index
  end
  
  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    #binding.pry
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    #binding.pry
    @article.update(title: params[:title], content: params[:content])
    #binding.pry
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.destroy
    redirect to '/articles'
  end

end
