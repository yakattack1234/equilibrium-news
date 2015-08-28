require "./config/environment"
require "./app/models/article"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, 'super secret'
  end
  
  get "/" do
    redirect"/home"
  end
  get "/home" do
    erb :home
  end
  get "/login" do
    erb :login
  end
  get "/sign-up" do
    erb :signup
  end
  post "/new_user" do
    User.create({:username => params[:user], :email => params[:email], :password => params[:password], :write => true})
    redirect '/home'
  end
  post "/old_user" do 
     @user = User.find_by({:username => params[:user]})
    if @user and @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/home'
    else
      redirect '/login'
    end
  end
  get "/write-a-article" do
    puts session[:user_id]
    if session[:user_id] == nil
      redirect '/home'
    end
    @user = User.find(session[:user_id])
    if  @user.write  
      erb :write
    else
      redirect '/home'
    end
  end
  post "/new_article" do 
    Article.create({:headline => params[:title], :text => params[:text], :rating => 50})
    redirect 'home'
  end
  get "/articles" do
    @articles = Article.all
    erb :articles
  end
  get "/read" do
    @selection = params[:article]
    @article = Article.find(@selection)
    erb :read
  end
  get "/sign-out" do 
    session[:user_id] = nil
    redirect '/home'
  end
end