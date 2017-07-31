require 'test_helper'

class SaleItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale = sales(:one)
    @sale_item = sale_items(:one)
  end

  test "should create sale_item" do
    sale_items_url = '/sales/' + @sale.id.to_s + '/sale_items'
    assert_difference('SaleItem.count') do
      post sale_items_url, params: {sale_item: {amount: @sale_item.amount, article_id: @sale_item.article_id, price: @sale_item.price, quantity: @sale_item.quantity, sale_id: @sale_item.sale_id } }
    end

    assert_redirected_to sale_url(@sale)
  end

  test "should destroy sale_item" do
    sale_item_url = '/sales/' + @sale.id.to_s + '/sale_items/' + @sale_item.id.to_s
    assert_difference('SaleItem.count', -1) do
      delete sale_item_url
    end

    assert_redirected_to sale_url(@sale)
  end
end
