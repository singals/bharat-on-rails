require 'test_helper'

class PurchaseItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase = purchases(:one)
    @purchase_item = purchase_items(:one)
  end

  test "should create purchase_item" do
    purchase_items_url = '/purchases/' + @purchase.id.to_s + '/purchase_items'
    assert_difference('PurchaseItem.count') do
      post purchase_items_url, params: { purchase_item: { article_id: @purchase_item.article_id, cost: @purchase_item.cost, price: @purchase_item.price, purchase_id: @purchase_item.purchase_id, quantity: @purchase_item.quantity } }
    end

    assert_redirected_to purchase_url(@purchase)
  end

  test "should destroy purchase_item" do
    purchase_item_url = '/purchases/' + @purchase.id.to_s + '/purchase_items/' + @purchase_item.id.to_s
    assert_difference('PurchaseItem.count', -1) do
      delete purchase_item_url
    end

    assert_redirected_to purchase_url(@purchase)
  end
end
