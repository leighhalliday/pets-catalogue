# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  if session[:user_id]
    redirect "/profile"
  else
    erb :login
  end
end

post '/login' do
  user = User.where(email: params[:email], password: params[:password]).first
  if !user
    erb :login
  else
    session[:user_id] = user.id
    redirect "/profile"
  end
end

get '/signup' do
  if session[:user_id]
    redirect "/profile"
  else
    erb :signup
  end
end

post '/signup' do
  user = User.create!(params)
  session[:user_id] = user.id
  redirect "/profile"
end

get '/logout' do
  session.clear
  redirect "/"
end

get '/profile' do
  if logged_in?
    @user = current_user
    erb :profile
  else
    redirect "/login"
  end
end

get '/pets' do
  @pets = Pet.all
  erb :"pets/index"
end

get '/pets/:id' do

end

def logged_in?
  !current_user.nil?
end

def current_user
  if session[:user_id]
    User.find session[:user_id]
  else
    nil
  end
end
