@toggle_sale_item = () -> $("#sale_item").toggle()

@calculate_cost = () ->
  quantity = $("#sale_item_quantity").val()
  price = $("#sale_item_price").val()
  item_cost = quantity * price
  $("#sale_item_amount").val(item_cost)
