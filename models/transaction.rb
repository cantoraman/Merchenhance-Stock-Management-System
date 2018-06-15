require_relative('../db/sql_runner')

class Transactions

  attr_reader :id, :_date, :item_id, :amount, :is_sold

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @_date = options['_date']
    @item_id = options['item_id'].to_i
  end

  def save()
    sql = "INSERT INTO houses
    (
      name,
      website
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @website]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def self.find(id)
    sql = "SELECT * FROM manufacturers
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    manufacturer = Manufacturers.new(result)
    return manufacturer
  end

  def self.all()
    sql = "SELECT * FROM manufacturers"
    manufacturers_data = SqlRunner.run(sql)
    manufacturers = map_items(manufacturers_data)
    return manufacturers
  end

  def self.map_items(manufacturer_data)
    return manufacturer_data.map { |manufacturer| Manufacturer.new(manufacturer) }
  end

end
