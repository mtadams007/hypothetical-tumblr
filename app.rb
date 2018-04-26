require "sinatra"
require "sinatra/activerecord"
require_relative "./models/friend"
require_relative "./models/post"
require_relative "./models/user"
require_relative "./models/user_friend"

set :database, {adapter: 'postgresql', database: 'hypothetical_tumbler'}

enable :sessions

get '/' do
  if user_exists?
    erb :index
  else
    erb :'users/new'
  end
end

get '/posts/new' do
  erb :'posts/new'
end

# USER STUFF

get '/login' do
  erb :login
end

post '/login' do
  @current_user = User.find_by(email: params[:email], password: params[:password])
  if @current_user != nil
      session[:id] = @current_user.id
      redirect '/profile'
  else
      redirect '/login'
  end
end

get '/profile' do
  if user_exists?
    @current_user=current_user
    erb :profile
  else
    redirect '/'
  end
end

get '/logout' do
    session.clear
    redirect '/'
end

post '/users/new' do
  if params[:password] != params[:password2]
    redirect '/'
  else
    @current_user = User.create(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], birthday: params[:birthday], password: params[:password])
    session[:id] = @current_user.id
    redirect '/profile'
  end
end

#POSTS

post '/posts/new' do
  Post.create(hypothetical: params[:hypothetical], tags: [params[:tag_one], params[:tag_two], params[:tag_three], params[:tag_four], params[:tag_five]])
  redirect '/profile'
end

private

def user_exists?
    (session[:id] != nil) ? true : false
end

def current_user
    User.find(session[:id])
end
