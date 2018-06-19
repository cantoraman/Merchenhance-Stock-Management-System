require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/items_controller')
require_relative('controllers/manufacturers_controller')
require_relative('controllers/transactions_controller')
require_relative('controllers/order_controller')
also_reload( './models/*' )


get '/' do
  erb( :index )
end
