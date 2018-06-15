require_relative('../db/sql_runner')

class Manufacturer

  attr_reader :id, :name, :website

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @website = options['website']
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
  
  def self.delete_all()
  sql = "DELETE FROM manufacturers;"
  SqlRunner.run(sql)
end

end
