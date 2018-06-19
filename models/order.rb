require_relative('../db/sql_runner')

class Order

  attr_reader :id, :order_date, :is_sold

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @order_date = options['order_date']
    @is_sold = options['order_id'].to_b
  end

  def save()
    sql = "INSERT INTO transactions
    (
      order_date,
      is_sold
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@order_date, @is_sold]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def self.find(id)
    sql = "SELECT * FROM orders
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    order = Orders.new(result)
    return order
  end

  def self.all()
    sql = "SELECT * FROM orders"
    order_data = SqlRunner.run(sql)
    orders = map_items(order_data)
    return orders
  end

  def self.map_items(order_data)
    return order_data.map { |order| Order.new(order) }
  end

  def self.delete_all()
    sql = "DELETE FROM orders"
    SqlRunner.run(sql)
  end
end















  @date = options['date']
      @is_sold = options['is_sold'].to_b
