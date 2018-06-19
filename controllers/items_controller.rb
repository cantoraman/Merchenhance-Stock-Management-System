require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/item.rb' )
require_relative( '../models/manufacturer.rb' )
require_relative( '../models/transaction.rb' )


#All
get '/items' do
  @items = Item.all()
  erb(:"items/index")
end

#NEW
get '/items/new' do
  @items = Item.all()
  @manufacturers = Manufacturer.all()
  erb ( :"items/new" )
end

get '/items/:id' do
  @item = Item.find(params[:id].to_i())
  erb(:"items/show_item")
end

get '/items/:id/restock' do
  @manufacturers = Manufacturer.all()
  @item = Item.find(params['id'])
  erb(:"items/restock")
end

get '/items/:id/edit' do
  @manufacturers = Manufacturer.all()
  @item = Item.find(params['id'])
  erb(:"items/edit")
end

post '/items/cart/:id/' do
  cart_hash=params
  p cart_hash

  redirect to ":items/index"
end


post '/items/:id' do
  item = Item.new(params)
  item.update
  redirect to "/items/#{params['id']}"
end

post '/items' do
  Item.new(params).save
  redirect to '/items'
end
