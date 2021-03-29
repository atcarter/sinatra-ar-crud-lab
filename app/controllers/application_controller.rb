
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do    
    erb :new
  end

  get '/articles/:id' do
    id = params[:id].to_i
    
    @article = Article.find_by(:id => id)

    erb :show
  end

  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    if @article
      erb :edit
    else
      redirect '/articles/:id'
    end
  end

  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    if @article && @article.update(title: params[:title], content: params[:content])
      redirect "/articles/#{@article.id}"
    else
      redirect "/articles/#{@article.id}/edit"
    end
  end

  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    if @article
      @article.delete
    end
    redirect to '/articles'
  end 

end
