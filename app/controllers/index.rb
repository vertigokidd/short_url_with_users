# GET =============================


get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/new' do
  erb :new
end

get '/error' do
  erb :error
end

get '/login' do
  erb :login
end

get '/user/:id' do
  erb :user_page
end

get '/error/:back' do
  erb :error
end

get '/shorten/:key' do
  erb :shorten
end

get '/:key' do
  link = Link.find_by_key(params[:key])
  redirect "http://#{link.long_url}"
end


# POST ============================


post '/shorten' do
  @long_url = params[:long_url]
  params[:key] = Link.generate_key
  p params
  link = Link.create(params)
  redirect "/shorten/#{link.key}"
end

post '/new' do
  if User.verify_password(params[:password], params[:verify_password])
  	params.delete("verify_password")
    user = User.create(params)
    redirect "/user/#{user.id}"
  else
  	redirect "/error/new"
  end
end

post '/login' do
  if User.validate_user(params[:email], params[:password])
  	user = User.find_by_email(params[:email])
    redirect "/user/#{user.id}"
  else
    redirect "/error/login"
  end
end