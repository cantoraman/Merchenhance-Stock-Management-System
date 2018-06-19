require_relative('../db/sql_runner')

class Item

  attr_reader :id, :name, :description, :cost, :price, :stock_level, :stock_low, :stock_medium, :manufacturer_id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @description = options['description']
    @cost = options['cost'].to_i
    @price = options['price'].to_i
    @stock_level = options['stock_level'].to_i
    @stock_low = options['stock_low'].to_i
    @stock_medium = options['stock_medium'].to_i
    @manufacturer_id = options['manufacturer_id'].to_i
  end

  def save()
    sql = "INSERT INTO items
    (
      name,
      description,
      cost,
      price,
      stock_level,
      stock_low,
      stock_medium,
      manufacturer_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6, $7 ,$8
    )
    RETURNING id"
    values = [@name, @description, @cost, @price, @stock_level, @stock_low, @stock_medium, @manufacturer_id]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def update()
    sql = "UPDATE items
    SET
    (
      name,
      description,
      cost,
      price,
      stock_level,
      stock_low,
      stock_medium,
      manufacturer_id
    ) =
    (
      $1, $2, $3, $4, $5, $6, $7 ,$8
    )
    WHERE id = $10"
    values = [@name, @description, @cost, @price, @stock_level, @stock_low, @stock_medium, @manufacturer_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM items
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def manufacturer_name()
    sql = "SELECT name FROM manufacturers WHERE id = $1"
    values = [@manufacturer_id]
    name= SqlRunner.run(sql, values)
    return name[0]["name"]
  end

  def self.all()
    sql = "SELECT * FROM items"
    item_data = SqlRunner.run(sql)
    items = map_items(item_data)
    return items
  end

  def self.map_items(item_data)
    return item_data.map { |item| Item.new(item) }
  end

  def self.find(id)
    sql = "SELECT * FROM items
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    item = Item.new(result)
    return item
  end

  def self.delete_all()
  sql = "DELETE FROM items;"
  SqlRunner.run(sql)
  end

  # def self.tag_list()
  # items = Item.all()
  # all_tags= []
  # for item in items
  #   all_tags.push(item.tag)
  # end
  # return all_tags.uniq!
  # end

end
