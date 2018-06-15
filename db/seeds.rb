require_relative('../models/manufacturer.rb')
require_relative('../models/item.rb')
require_relative('../models/transaction.rb')

Transaction.delete_all()
Item.delete_all()
Manufacturer.delete_all()

house4= House.new({
  "house_name" => "Slytherin",
  "logo_url" => "https://www.thestoreofrequirement.com.au/assets/full/2066.jpg"
  })
house1.save()
house2.save()
house3.save()
house4.save()


student1 = Student.new({
  "first_name" => "Harry",
  "last_name" => "Potter",
  "house_id" => house1.id,
  "age" => "12"
  })
student2 = Student.new({
  "first_name" => "Ron",
  "last_name" => "Weasley",
  "house_id" => house1.id,
  "age" => "13"
  })
student3 = Student.new({
  "first_name" => "Hermoine",
  "last_name" => "Granger",
  "house_id" => house1.id,
  "age" => "10"
  })
student4 = Student.new({
  "first_name" => "Draco",
  "last_name" => "Malfoy",
  "house_id" => house4.id,
  "age" => "15"
  })


  student1.save()
  student2.save()
  student3.save()
  student4.save()
