helpers do

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||=
      if session[:user_id]
        User.find session[:user_id]
      else
        nil
      end
  end

end

# Homepage (Root path)
get '/' do
  erb :home
end

# Signup page
get '/users/new' do
  erb :"users/new"
end

post '/users/create' do
  # create a new user with the data (in params) that was posted to us
  user = User.create(params[:user])

  # (logging in) when we have a new user, create a session for them
  session[:user_id] = user.id

  # redirect user to their profile page
  redirect '/profile'
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by({email: params[:email]})
  if user && user.password == params[:password]
    # log them into the system
    session[:user_id] = user.id
    redirect '/profile'
  else
    # user was not found
    # or password was incorrect
    redirect '/login'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/profile' do
  erb :"users/profile"
end

get '/pets' do
  @pets = Pet.all
  erb :"pets/index"
end

get '/pets/new' do
  erb :"pets/new"
end

post '/pets/create' do
  name      = params[:name]
  genus     = params[:genus]
  image_url = params[:image_url]

  # new pet with no relation to a user
  #pet = Pet.create({name: name, genus: genus, image_url: image_url})

  # new pet related to user that is logged in
  pet = current_user.pets.create({
    name: name,
    genus: genus,
    image_url: image_url
  })

  redirect "/pets/#{pet.id}"
end

get '/pets/:id' do
  @pet = Pet.find(params[:id])
  erb :"pets/show"
end

get '/pets/:pet_id/outfits' do
  @pet = Pet.find(params[:pet_id])
  @outfits = @pet.outfits
  erb :"outfits/index"
end

get '/pets/:pet_id/outfits/new' do
  @pet = Pet.find(params[:pet_id])
  erb :"outfits/new"
end

post '/pets/:pet_id/outfits/create' do
  @pet = Pet.find(params[:pet_id])

  pet_outfit = @pet.outfits.create(params[:outfit])

  redirect "/pets/#{@pet.id}/outfits"
end