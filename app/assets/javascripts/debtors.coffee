# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@calculate_interest = () ->
  rate = $('#temp_interest').val()
  sale_records = $('#sales_table tr td')
  max_row_index = (sale_records.length / 4) - 1
  x = 0
  total_payables = 0

  for i in [0..max_row_index]
    sale_date = sale_records[x].innerHTML
    sale_date = sale_date.split("-");
    sale_date = new Date(sale_date[2], sale_date[1] - 1, sale_date[0]);
    today = new Date()

    amount = sale_records[x + 1].innerHTML

    months_diff = new Date(today - sale_date)/1000/60/60/24/30
    months_diff = months_diff.toFixed(2)

    interest = amount * (rate * 0.01 ) * months_diff
    interest = interest.toFixed()
    console.log(interest)

    sale_records[x+2].innerHTML = interest
    total_payables = parseFloat(total_payables) + parseFloat(amount) + parseFloat(interest)

    x += 4

  deposits_records = $('#deposits_table tr td')
  max_row_index = (deposits_records.length / 3) - 1
  x = 0

  for i in [0..max_row_index]
    deposit_date = deposits_records[x].innerHTML
    deposit_date = deposit_date.split("-");
    deposit_date = new Date(deposit_date[2], deposit_date[1] - 1, deposit_date[0]);
    today = new Date()

    amount = deposits_records[x + 1].innerHTML

    months_diff = new Date(today - deposit_date)/1000/60/60/24/30
    months_diff = months_diff.toFixed(2)

    interest = amount * (rate * 0.01 ) * months_diff
    interest = interest.toFixed()
    console.log(interest)

    deposits_records[x+2].innerHTML = interest
    total_payables = parseFloat(total_payables) - parseFloat(amount) - parseFloat(interest)

    x += 3
  $('#final_amount_to_settle').val(total_payables)