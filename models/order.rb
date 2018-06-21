require_relative('../db/sql_runner')
require_relative('transaction')
require_relative('item')

class Order

  attr_reader :id, :order_date, :is_sold, :is_processed

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @order_date = options['order_date']
    @is_sold = options['is_sold']
    @is_processed = options['is_processed']
  end

  def save()
    sql = "INSERT INTO orders
    (
      order_date,
      is_sold,
      is_processed
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@order_date, @is_sold, @is_processed]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def items()
     sql = "SELECT items.*
     FROM items
     INNER JOIN transactions
     ON items.id = transactions.item_id
     WHERE transactions.order_id = $1"
     values = [@id]
     data = SqlRunner.run(sql, values)
     return data.map { |item| Item.new(item) }
  end

  def number_of_items()
    item_list=items()
    if item_list.length > 0
       return item_list.length
     else
      return 0
    end
  end

  def update()
    sql = "UPDATE orders
    SET
    (
      order_date,
      is_sold,
      is_processed
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@order_date, @is_sold, @is_processed, @id]
    SqlRunner.run(sql, values)
  end

  def process_self()
    @is_processed = true
  end

  def self.find(id)
    sql = "SELECT * FROM orders
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    order = Order.new(result)
    return order
  end

  def self.delete(id)
    transactions = Transaction.transactions_of_order(id)
    transactions.each { |transaction|
      item = Item.find(transaction.item_id)
      item.raise_stock_level(transaction.amount)
      item.update()
      transaction.delete() }

    sql = "DELETE FROM orders
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end



  def self.show_till()
    gain=0
    orders = Order.find_processed()
    orders.map{ |order|
      transactions = Transaction.transactions_of_order(order.id)

      transactions.map{ |transaction|
        item=Item.find(transaction.item_id)
        gain+=(item.price*transaction.amount)
      }
    }
    return gain
  end

  def self.process(id)
    order = Order.find(id)
    transactions = Transaction.transactions_of_order(order.id)
    order.process_self()
    order.update()
  end


  def self.find_unprocessed()
    sql = "SELECT * FROM orders
    WHERE is_processed = false"
    result = SqlRunner.run(sql).first
    if result
    order = Order.new(result)
    return order
    else
    return nil
    end
  end

  def self.find_processed()
    sql = "SELECT * FROM orders
    WHERE is_processed = true"
    order_data = SqlRunner.run(sql)
    orders = map_items(order_data)
    return orders
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
