@toggle_sale_item = () -> $("#sale_item").toggle()

@calculate_cost = () ->
  quantity = $("#sale_item_quantity").val()
  price = $("#sale_item_price").val()
  item_cost = quantity * price
  $("#sale_item_amount").val(item_cost)
  sale_items_amounts = $('*[id*=sale_item_amount]:visible')
  total_amount = 0;
  for si in sale_items_amounts
    total_amount = parseFloat(total_amount) + parseFloat(si.value)
  $("#sale_total_amount_field").val(total_amount)