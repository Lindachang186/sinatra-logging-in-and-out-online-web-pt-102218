require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.password == params[:password]
      session[:user_id]=@user.id
      redirect '/account'
    else
      redirect '/error'
    end 
  end

  get '/account' do
    if @user = Helpers.current_user(session)
    erb :account
    else
      redirect '/error'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/error' do
    erb :error
  end


end
