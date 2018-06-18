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
