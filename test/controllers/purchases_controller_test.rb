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

  test "should be able to record a new purchase" do
    post '/purchases', :params => {:purchase => {:seller_name => 'test seller', :city => 'Kurukshetra', :phone => '9876543210', :invoice_number => '123',
                                         :purchase_items_attributes => [{:article_id => 980190962, :price => 210, :quantity => 300, :cost => 63000},
                                                                        {:article_id => 113629430, :price => 150, :quantity => 100, :cost => 15000}],
                                         :total_cost => 78000}}

    assert_response :redirect
    @latestPurchase = Purchase.order('created_at').last
    @latestPurchaseItems = @latestPurchase.purchase_items
    assert_equal 'test seller', @latestPurchase.seller_name, 'Seller name does not match'
    assert_equal 'Kurukshetra', @latestPurchase.city, 'Seller city does not match'
    assert_equal '9876543210', @latestPurchase.phone, 'Seller Phone does not match'
    assert_equal 123, @latestPurchase.invoice_number, 'Invoice number does not match'
    assert_equal 78000, @latestPurchase.total_cost, 'Total cost of purchase does not match'

    assert_equal 2, @latestPurchaseItems.size, "Number of purchase items does not match"

    assert_equal 980190962, @latestPurchaseItems[0].article_id, 'Article of purchase-item does not match'
    assert_equal 210, @latestPurchaseItems[0].price, 'Price of purchase-item does not match'
    assert_equal 300, @latestPurchaseItems[0].quantity, 'Quantity of purchase-item does not match'
    assert_equal 63000, @latestPurchaseItems[0].cost, 'Cost of purchase-item does not match'

    assert_equal 113629430, @latestPurchaseItems[1].article_id, 'Article of purchase-item does not match'
    assert_equal 150, @latestPurchaseItems[1].price, 'Price of purchase-item does not match'
    assert_equal 100, @latestPurchaseItems[1].quantity, 'Quantity of purchase-item does not match'
    assert_equal 15000, @latestPurchaseItems[1].cost, 'Cost of purchase-item does not match'
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
