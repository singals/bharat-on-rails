require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase = purchases(:one)
  end

  # custom
  test "should be able to get all purchases" do
    get('/purchases')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/purchase_get_all_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "should be able to get a purchase by id" do
    get('/purchases/980190962')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/purchase_one_get_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  # auto-generated
  test "should get index" do
    get purchases_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_url
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post purchases_url, params: { purchase: { city: @purchase.city, invoice_number: @purchase.invoice_number, phone: @purchase.phone, seller_name: @purchase.seller_name, total_cost: @purchase.total_cost } }
    end

    assert_redirected_to purchase_url(Purchase.last)
  end

  test "should show purchase" do
    get purchase_url(@purchase)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_url(@purchase)
    assert_response :success
  end

  test "should update purchase" do
    patch purchase_url(@purchase), params: { purchase: { city: @purchase.city, invoice_number: @purchase.invoice_number, phone: @purchase.phone, seller_name: @purchase.seller_name, total_cost: @purchase.total_cost } }
    assert_redirected_to purchase_url(@purchase)
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete purchase_url(@purchase)
    end

    assert_redirected_to purchases_url
  end
end
