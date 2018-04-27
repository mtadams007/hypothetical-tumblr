require "sinatra"
require "sinatra/activerecord"
require_relative "./models/post"
require_relative "./models/user"


set :database, {adapter: 'postgresql', database: 'hypothetical_tumbler'}

enable :sessions

get '/' do
  if user_exists?
    @current_user = current_user
    @posts = Post.where(user_id: session[:id])
    erb :index
  else
    erb :'users/new'
  end
end

get '/friend/:id' do
  if user_exists?
    if session[:id] == params[:id]
      redirect '/profile'
    else
      @friend = User.find(params[:id])
      @friend_posts = Post.where(user_id: params[:id])
      erb :friend
    end
  else
    redirect '/'
  end
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
  erb :login
end

post '/login' do
  @current_user = User.find_by(username: params[:username], password: params[:password])
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
    @posts = Post.where(user_id: session[:id])
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
  Post.create(hypothetical: params[:hypothetical], tags: [params[:tag_one], params[:tag_two], params[:tag_three], params[:tag_four], params[:tag_five]], user_id: session[:id])
  redirect '/profile'
end

put '/posts/edit/:id' do
  @current_post = Post.find(params[:id])
  @current_post.update(hypothetical: params[:hypothetical], tags: [params[:tag_one], params[:tag_two], params[:tag_three], params[:tag_four], params[:tag_five]], user_id: session[:id])
  redirect '/profile'
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
      erb :profile
    else
      erb :friend
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

put '/profile/edit/:id' do
  @current_user = current_user
  if params[:password] == params[:password2]
    @current_user.update(password: params[:password])
  end
  redirect '/profile'
end

delete '/posts/edit/:id' do
  Post.destroy(params[:id])
  redirect '/profile'
end

delete '/profile/edit/:id' do
  User.destroy(params[:id])
  session.clear
  redirect '/profile'
end

private

def user_exists?
    (session[:id] != nil) ? true : false
end

def current_user
    User.find(session[:id])
end
