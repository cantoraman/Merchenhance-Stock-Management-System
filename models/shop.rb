require('date')
require_relative('order')
require_relative('item')
require_relative('transaction')

class Shop


  def sell_items(items)
    @order=Order.new({
      "order_date" => DateTime.now,
      "is_sold" => "True"
      })
    @order.save()

    items.each { |id, amount|
      item=Item.find(id)
      item.stock_level -= amount
      item.update()
      transaction=Transaction.new({
        "item_id" => item.id,
        "order_id" => @order.id,
        "amount" => amount
        })
      transaction.save()
      }
  end

  def add_to_cart(items)
    @cart.push
  end

end
