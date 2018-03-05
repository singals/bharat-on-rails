@toggle_purchase_item = () -> $("#purchase_item").toggle()

@calculate_cost = () ->
  quantity = $("#purchase_item_quantity").val()
  price = $("#purchase_item_price").val()
  item_cost = quantity * price
  $("#purchase_item_cost").val(item_cost)
  purchase_items_costs = $('*[id*=purchase_item_cost]:visible')
  total_cost = 0;
  for item in purchase_items_costs
    total_cost = parseFloat(total_cost) + parseFloat(item.value)
  $("#purchase_total_cost_field").val(total_cost)