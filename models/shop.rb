require('date')
require_relative('order')
require_relative('item')
require_relative('transaction')

class Shop


  def sell_items(item_ids, amounts)
    @order=Order.new({
      "order_date" => DateTime.now,
      "is_sold" => "True"
      })
    @order.save()

    for i in 0..(item_ids.length)

      item=Item.find(item_ids[i])
      item.stock_level -= amounts[i]
      item.update()
      transaction=Transaction.new({
        "item_id" =>
        })

    end

    }







end
