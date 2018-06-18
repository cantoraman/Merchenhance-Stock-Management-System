require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/item.rb' )
require_relative( '../models/manufacturer.rb' )
require_relative( '../models/transaction.rb' )


#All
get '/transactions' do
  @transactions = Transaction.all()
  erb(:"transactions/index")
end

#NEW
get '/transactions/new' do
  @transactions = Transaction.all()
  erb ( :"transactions/new" )
end

post '/transactions' do
  Transaction.new(params).save
  redirect to '/transactions'
end
