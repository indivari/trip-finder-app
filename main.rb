     
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require_relative 'models/location.rb'
require_relative 'models/rating.rb'
require_relative 'models/user.rb'

require 'bcrypt'

enable :sessions

# helper functions

def logged_in?()
  if session[:user_id]
    return true
  else
    return false
  end
end

def current_user()
#   conn = PG.connect(dbname: 'goodfoodhunting')
  sql = "select * from users where user_id = #{ session[:user_id]}"
  # result = conn.exec(sql)
#  email = result[0]['email']
 user = db_query(sql).first
# user = result[0]
#  conn.close 
#  return email 
return OpenStruct.new(user)
end


get '/' do  
  locations = all_locations
  city = 'Australia'

  erb :index, locals: {
    locations:locations,
  city:city}
end

get '/locations/new' do 
  if logged_in?
    erb(:new)
  else
    redirect '/login'
  end

end

get '/melbourne' do 
  locations = city_locations('Melbourne')
  city ='Melbourne'

  erb(:index, locals: {
   locations:locations,
    city:city})
end

get '/sydney' do 
  locations=  city_locations('Sydney')
  city = 'Sydney'
  erb(:index, locals: {
    locations:locations,
    city:city})

end

get '/adelaide' do 
  locations=  city_locations('Adelaide')
  city = 'Adelaide'
  erb(:index, locals: {
    locations:locations,
    city:city})
end

get '/perth' do 
  locations=  city_locations('Perth')
  city = 'Perth'
  erb(:index, locals: {
    locations:locations,
    city:city})
end

get '/brisbane' do 
  locations=  city_locations('Brisbane')
  city = 'Brisbane'
  erb(:index, locals: {
    locations:locations,
    city:city})
end


post '/locations' do 
  redirect '/login' unless logged_in?

  # loc_name = params['name']
  # userid = session[:user_id]

  create_location(params['name'], params['description'],params['image_url'],params['cities'])

  # result = db_query("select * from locations where name='#{loc_name}'").first
  # loc_id = result['location_id']  

  # db_query("insert into user_location_ratings(user_id,location_id,rating) values(#{userid},#{loc_id},0)")
  redirect '/'

 
end

post '/ratings' do 

    params = request.body.read
    json_params = JSON.parse(params)

    location_id = json_params['locationId'].to_s
    rating = json_params['rating'].to_s
    user_id = session[:user_id]

    create_or_update_rating(user_id, location_id, rating)
    
end


get '/location/:id' do 
  location = db_query('select * from locations where location_id = $1',[params['id']]).first

  erb(:show, locals: {location:location})
end

get '/location/:id/edit' do 
  sql = 'select * from locations where location_id = $1'
  location = db_query(sql, [params['id']]).first
  erb(:edit, locals: {
    location:location
  })
end

put '/locations/:id' do 
  update_location(
    params['name'],
    params['description'],
    params['image_url'],
    params['cities'],
    params['id']
  )

  redirect '/'
end

delete '/location/:id' do 
 delete_location(params['id'])

 redirect '/'
end

get '/login' do 
  erb(:login)
end

get '/users/new' do 
  erb(:signup)
end

post '/users' do 
  name = params['name']
  email = params['email']
  password = params['password']
  
  password_digest = BCrypt::Password.create(password)
  create_user(name,email,password_digest)
  redirect '/login'


end

post '/session' do 
  email = params["email"]
  password = params["password"]

result = check_email(email)

  if result.count >0 && BCrypt::Password.new(result[0]['password_digest'])==password
    session[:user_id] = result[0]['user_id']
    redirect '/'
  else 
    erb(:login)

  end

end

delete '/session' do 
  session[:user_id] =nil
  redirect '/login'
end