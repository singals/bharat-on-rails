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

  test "should be able to get a purchase by id" do
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
