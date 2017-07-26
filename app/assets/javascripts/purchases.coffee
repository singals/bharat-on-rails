@toggle_purchase_item = () -> $("#purchase_item").toggle()

@calculate_cost = () ->
  quantity = $("#purchase_item_quantity").val()
  price = $("#purchase_item_price").val()
  item_cost = quantity * price
  $("#purchase_item_cost").val(item_cost)
