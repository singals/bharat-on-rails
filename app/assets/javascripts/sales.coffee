@calculate_amount = () ->
  quantities = $(".sale_item_quantity")
  prices = $(".sale_item_price")
  amounts = $(".sale_item_amount")

  total_amount = 0;
  maxIndexVal = quantities.length - 1

  for i in [0..maxIndexVal]
    amount = quantities[i].value * prices[i].value
    amounts[i].value = amount
    total_amount = parseFloat(total_amount) + parseFloat(amount)

  $("#sale_total_amount_field").val(total_amount)
