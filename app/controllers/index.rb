enable :sessions


# GET =============================


get '/' do
  # if session[:user] != nil
  #   redirect "/user/#{session[:user]}"
  # else
  erb :index
end

get '/new' do
  erb :new
end

get '/error' do
  erb :error
end

get '/login' do
  if session[:user] != nil
    redirect "/user/#{session[:user]}"
  else
    erb :login
  end
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end

get '/user/:id' do
  p params[:id]
  if session[:user] == params[:id]
    erb :user_page
  else
    erb :error
  end
end

get '/error/:back' do
  erb :error
end

get '/shorten/:key' do
  erb :shorten
end

get '/:key' do
  link = Link.find_by_key(params[:key])
  redirect "#{link.long_url}"
end


# POST ============================


post '/shorten' do
  valid_url = Link.validate_format(params[:long_url])
  if Link.validate_url(valid_url)
    @long_url = valid_url
    params[:key] = Link.generate_key
    if session[:user] != nil
      params[:user_id] = session[:user]
    end
    link = Link.create(params)
    redirect "/shorten/#{link.key}"
  else
    redirect "/error"
  end
end

post '/new' do
  if User.verify_password(params[:password], params[:verify_password])
  	params.delete("verify_password")
    user = User.create(params)
    session[:user] = user.id.to_s
    redirect "/user/#{user.id}"
  else
  	redirect "/error/new"
  end
end

post '/login' do
  if User.validate_user(params[:email], params[:password])
  	user = User.find_by_email(params[:email])
    session[:user] = user.id.to_s
    redirect "/user/#{user.id}"
  else
    redirect "/error/login"
  end
end