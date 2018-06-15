require_relative('../db/sql_runner')

class Transactions

  attr_reader :id, :_date, :item_id, :amount, :is_sold

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @_date = options['_date']
    @item_id = options['item_id'].to_i
    @amount = options['amount'].to_i
    @is_sold = options['is_sold'].to_b
  end

  def save()
    sql = "INSERT INTO transactions
    (
      _date,
      item_id,
      amount,
      is_sold
    )
    VALUES
    (
      $1, $2, $3 $4
    )
    RETURNING id"
    values = [@_date, @item_id, @amount, @is_sold]
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

end
