@calculate_cost = () ->
  quantities = $(".purchase_item_quantity")
  prices = $(".purchase_item_price")
  costs = $(".purchase_item_cost")

  total_cost = 0;
  maxIndexVal = quantities.length - 1

  for i in [0..maxIndexVal]
    cost = quantities[i].value * prices[i].value
    costs[i].value = cost
    total_cost = parseFloat(total_cost) + parseFloat(cost)

  $("#purchase_total_cost_field").val(total_cost)
