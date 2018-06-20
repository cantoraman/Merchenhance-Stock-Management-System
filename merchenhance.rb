require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/items_controller')
require_relative('controllers/manufacturers_controller')
require_relative('controllers/transactions_controller')
require_relative('controllers/order_controller')
require_relative('models/order')

also_reload( './models/*' )


get '/' do
  erb( :index )
end
