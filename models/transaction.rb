require_relative('../db/sql_runner')

class Transaction

  attr_reader :id, :item_id, :order_id, :amount

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @item_id = options['item_id'].to_i
    @order_id = options['order_id'].to_i
    @amount = options['amount'].to_i
  end

  def save()
    sql = "INSERT INTO transactions
    (
      item_id,
      order_id,
      amount
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@item_id, @order_id, @amount]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    transaction = Transactions.new(result)
    return transaction
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    transactions_data = SqlRunner.run(sql)
    transactions = map_items(transactions_data)
    return transactions
  end

  def self.map_items(transaction_data)
    return transaction_data.map { |transaction| Transaction.new(transaction) }
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end
end
