# frozen_string_literal: true

require 'test_helper'

class SalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale = sales(:one)
  end

  # custom
  test "should be able to get all sales" do
    get('/sales')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/sale_get_all_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "should be able to get a sales by id" do
    get('/sales/980190962')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/sale_one_get_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'

    get('/sales/298486374')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/sale_two_get_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "should be able to create a new cash sale" do
    @article = Article.find(980190962)
    initial_qty = @article.availabe_units

    post '/sales', params: {sale: {nature: 'CASH', village: 'test village', phone: '9876543210',
                                   sale_items_attributes: [{:article_id => 980190962, :price => 240, :quantity => 1, :amount => 240}],
                                   total_amount: 240}}

    assert_response :redirect
    @latestSale = Sale.order('created_at').last
    @latestSaleItems = @latestSale.sale_items
    assert_equal 'CASH', @latestSale.nature, 'Nature of sale does not match'
    assert_nil @latestSale.debtor, 'Debtor id does not match'
    assert_equal 'test village', @latestSale.village, 'Village does not match'
    assert_equal '9876543210', @latestSale.phone, 'Phone does not match'
    assert_equal 240, @latestSale.total_amount, 'Total amount of sale does not match'

    assert_equal 1, @latestSaleItems.size, "Number of sale items does not match"
    assert_equal 980190962, @latestSaleItems[0].article_id, 'Article of sale-item does not match'
    assert_equal 240, @latestSaleItems[0].price, 'Price of sale-item does not match'
    assert_equal 1, @latestSaleItems[0].quantity, 'Quantity of sale-item does not match'
    assert_equal 240, @latestSaleItems[0].amount, 'Amount of sale-item does not match'

    @article = Article.find(980190962)
    current_qty = @article.availabe_units
    assert_equal initial_qty - 1, current_qty, 'Inventory/Stock shall be adjusted'
  end

  test "should be able to create a new credit sale" do
    post '/sales', params: {sale: {nature: 'CREDIT', debtor_id: '980190962', village: 'test village', phone: '9876543211',
                                   sale_items_attributes: [{:article_id => 298486374, :price => 500, :quantity => 2, :amount => 1000},
                                                           {:article_id => 980190962, :price => 240, :quantity => 1, :amount => 240}],
                                   total_amount: 1240}}

    assert_response :redirect
    @latestSale = Sale.order('created_at').last
    @latestSaleItems = @latestSale.sale_items
    assert_equal 'CREDIT', @latestSale.nature, 'Nature of sale does not match'
    assert_equal 980190962, @latestSale.debtor_id, 'Debtor id does not match'
    assert_equal 'test village', @latestSale.village, 'Village does not match'
    assert_equal '9876543211', @latestSale.phone, 'Phone does not match'
    assert_equal 1240, @latestSale.total_amount, 'Total amount of sale does not match'

    assert_equal 2, @latestSaleItems.size, "Number of sale items does not match"

    assert_equal 298486374, @latestSaleItems[0].article_id, 'Article of sale-item does not match'
    assert_equal 500, @latestSaleItems[0].price, 'Price of sale-item does not match'
    assert_equal 2, @latestSaleItems[0].quantity, 'Quantity of sale-item does not match'
    assert_equal 1000, @latestSaleItems[0].amount, 'Amount of sale-item does not match'

    assert_equal 980190962, @latestSaleItems[1].article_id, 'Article of sale-item does not match'
    assert_equal 240, @latestSaleItems[1].price, 'Price of sale-item does not match'
    assert_equal 1, @latestSaleItems[1].quantity, 'Quantity of sale-item does not match'
    assert_equal 240, @latestSaleItems[1].amount, 'Amount of sale-item does not match'
  end

  # auto-generated
  test "should get index" do
    get sales_url
    assert_response :success
  end

  test "should get new" do
    get new_sale_url
    assert_response :success
  end

  test "should create sale" do
    assert_difference('Sale.count') do
      post sales_url, params: { sale: { debtor_id: @sale.debtor_id, nature: @sale.nature, phone: @sale.phone, total_amount: @sale.total_amount, village: @sale.village } }
    end

    assert_redirected_to sale_url(Sale.last)
  end

  test "should show sale" do
    get sale_url(@sale)
    assert_response :success
  end

  test "should get edit" do
    get edit_sale_url(@sale)
    assert_response :success
  end

  test "should update sale" do
    patch sale_url(@sale), params: { sale: { debtor_id: @sale.debtor_id, nature: @sale.nature, phone: @sale.phone, total_amount: @sale.total_amount, village: @sale.village } }
    assert_redirected_to sale_url(@sale)
  end

  test "should destroy sale" do
    assert_difference('Sale.count', -1) do
      delete sale_url(@sale)
    end

    assert_redirected_to sales_url
  end
end
