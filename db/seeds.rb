require_relative('../models/manufacturer.rb')
require_relative('../models/item.rb')
require_relative('../models/transaction.rb')

Transaction.delete_all()
Item.delete_all()
Manufacturer.delete_all()

manufacturer1= Manufacturer.new({
  "name" => "Skynet",
  "website" => "www.skynet.com"
  })

manufacturer2= Manufacturer.new({
  "name" => "Stark Industries",
  "website" => "www.startkindustries.com"
  })

manufacturer3= Manufacturer.new({
  "name" => "Wayne Enterprises",
  "website" => "www.wayneenterprises.com"
  })

manufacturer4= Manufacturer.new({
  "name" => "LexCorp",
  "website" => "www.lexcorp.com"
  })
manufacturer1.save()
manufacturer2.save()
manufacturer3.save()
manufacturer4.save()


item1 = Item.new({
  "name" => "T500",
  "description" => "A State of the art combat machine. Easy to set up",
  "tag" => "android",
  "cost" => "1200000",
  "price" => "1600000",
  "stock_level" => "100",
  "stock_low" => "20",
  "stock_medium" => "50",
  "manufacturer_id" => manufacturer1.id
  })

item2 = Item.new({
  "name" => "Jericho",
  "description" => "They say the best weapon is one you never have to fire. This is the weapon you only have to fire once.",
  "tag" => "rocket",
  "cost" => "800000",
  "price" => "900000",
  "stock_level" => "100",
  "stock_low" => "20",
  "stock_medium" => "50",
  "manufacturer_id" => manufacturer2.id
  })

item3 = Item.new({
  "name" => "W4 Wraith Fighter",
  "description" => "They'll never see it coming.",
  "tag" => "plane",
  "cost" => "2500000",
  "price" => "4100000",
  "stock_level" => "40",
  "stock_low" => "10",
  "stock_medium" => "30",
  "manufacturer_id" => manufacturer3.id
  })

item4 = Item.new({
  "name" => "LexCorp Light Walker",
  "description" => "Anti infantry, anti vehicle: What more do you need?",
  "tag" => "walker",
  "cost" => "900000",
  "price" => "1000000",
  "stock_level" => "20",
  "stock_low" => "5",
  "stock_medium" => "10",
  "manufacturer_id" => manufacturer4.id
  })

  item1.save()
  item2.save()
  item3.save()
  item4.save()
