require "sinatra"
require "sinatra/activerecord"
require_relative "./models/post"
require_relative "./models/user"
require "will_paginate"
require "will_paginate/active_record"

class MyApp < Sinatra::Base
  register WillPaginate::Sinatra
end


# set :database, {adapter: 'postgresql', database: 'hypothetical_tumbler'}

enable :sessions

get '/' do
  if user_exists?
    @current_user = current_user
    @posts = Post.where(user_id: session[:id])
    redirect '/profile'
  else
    erb :'users/new'
  end
end

get '/profile' do
  if user_exists?
    @current_user = current_user
    @posts = Post.where(user_id: session[:id])
    erb :profile
  else
    redirect '/'
  end
end

get '/profile/edit' do
  if user_exists?
    @current_user = current_user
    @posts = Post.where(user_id: session[:id])
    erb :'users/edit'
  else
    redirect '/'
  end
end


get '/friend/:id' do
  if user_exists?
    if session[:id] == params[:id]
      redirect '/posts'
    else
      @current_user = User.find(params[:id])
      erb :posts
    end
  else
    redirect '/'
  end
end

get '/friends' do
  erb :friends
end

get '/posts/new' do
  if user_exists?
    erb :'posts/new'
  else
    redirect '/'
  end
end

# USER STUFF

get '/login' do
  if user_exists?
    redirect '/profile'
  else
    erb :login
  end
end

post '/login' do
  @current_user = User.find_by(username: params[:username], password: params[:password])
  if @current_user != nil
      session[:id] = @current_user.id
      redirect '/posts'
  else
      redirect '/login'
  end
end

get '/posts' do
  if user_exists?
    @current_user=current_user
    erb :posts
  else
    redirect '/'
  end
end

get '/logout' do
    session.clear
    redirect '/'
end

post '/feed' do
  if User.exists?(:username => params[:username])
    @friend = User.find_by(username: params[:username])
    @friend_posts = Post.where(user_id: @friend.id)
    redirect "/friend/#{@friend.id}"
  else
    @query = params[:username]
    erb :feed
  end
end


post '/users/new' do
  if params[:password] != params[:password2] || User.exists?(:username => params[:username])
    redirect '/'
  else
    @current_user = User.create(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], birthday: params[:birthday], username: params[:username], password: params[:password])
    session[:id] = @current_user.id
    redirect '/profile'
  end
end

#POSTS

post '/posts/new' do
  Post.create(hypothetical: params[:hypothetical], tags: [params[:tag_one], params[:tag_two], params[:tag_three], params[:tag_four], params[:tag_five]], user_id: session[:id], main_tag: params[:tag_one])
  redirect '/posts'
end

put '/posts/edit/:id' do
  @current_post = Post.find(params[:id])
  @current_post.update(hypothetical: params[:hypothetical], tags: [params[:tag_one], params[:tag_two], params[:tag_three], params[:tag_four], params[:tag_five]], user_id: session[:id], main_tag: params[:tag_one])
  redirect '/posts'
end

put '/friend/:id' do
  @current_post = Post.find(params[:post_id])

  array = @current_post.comment
  array2 = array.push("#{current_user.firstname} answers: #{params[:commentary]}")

  @current_post.update(comment: array2)
    @friend_posts = Post.where(user_id: params[:id])
    @friend = User.find(params[:id])
    if @friend == current_user
      @current_user = current_user
      @posts = Post.where(user_id: session[:id])
      erb :posts
    else
      @current_user = @friend
      erb :posts
  end
end


get '/posts/edit/:id' do
  if Post.find(params[:id]).user_id == session[:id]
    @current_post = Post.find(params[:id])
    erb :'posts/edit'
  else
    redirect '/'
  end
end

put '/profile/edit' do
  @current_user = current_user
  @posts = Post.where(user_id: session[:id])
  if params[:password] == params[:password2]
    @current_user.update(password: params[:password])
    redirect '/profile'
  else
    redirect '/profile/edit'
  end
end

delete '/posts/edit/:id' do
  Post.destroy(params[:id])
  redirect '/posts'
end

delete '/profile/edit' do
  User.destroy(session[:id])
  session.clear
  redirect '/'
end

private

def user_exists?
    (session[:id] != nil) ? true : false
end

def current_user
    User.find(session[:id])
end
