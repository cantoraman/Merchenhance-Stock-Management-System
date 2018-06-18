require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/item.rb' )
require_relative( '../models/manufacturer.rb' )
require_relative( '../models/transaction.rb' )


#All
get '/manufacturers' do
  @manufacturers = Manufacturer.all()
  erb(:"manufacturers/index")
end

#NEW
get '/manufacturers/new' do
  @manufacturers = Manufacturer.all()
  erb ( :"manufacturers/new" )
end

post '/manufacturers' do
  Manufacturer.new(params).save
  redirect to '/manufacturers'
end
