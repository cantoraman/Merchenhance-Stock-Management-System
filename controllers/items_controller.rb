

#All
get '/items' do
  @items = Items.all()
  erb(:"items/index")
end

#NEW
get '/items/new' do
  erb ( :"items/new" )
end
