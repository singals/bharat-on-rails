require 'test_helper'

class DebtorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @debtor = debtors(:one)
  end

  test "should get index" do
    get debtors_url
    assert_response :success
  end

  test "should get new" do
    get new_debtor_url
    assert_response :success
  end

  test "should create debtor" do
    assert_difference('Debtor.count') do
      post debtors_url, params: { debtor: { is_active: @debtor.is_active, name: @debtor.name, phone: @debtor.phone, village: @debtor.village } }
    end

    assert_redirected_to debtor_url(Debtor.last)
  end

  test "should show debtor" do
    get debtor_url(@debtor)
    assert_response :success
  end

  test "should get edit" do
    get edit_debtor_url(@debtor)
    assert_response :success
  end

  test "should update debtor" do
    patch debtor_url(@debtor), params: { debtor: { is_active: @debtor.is_active, name: @debtor.name, phone: @debtor.phone, village: @debtor.village } }
    assert_redirected_to debtor_url(@debtor)
  end

  test "should destroy debtor" do
    delete debtor_url(@debtor)
    @debtor = Debtor.find(@debtor.id)
    assert_not @debtor.is_active

    assert_redirected_to debtors_url
  end

  test "should be able to get all debtors" do
    get('/debtors')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/debtor_get_all_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "should be able to get a debtor by id" do
    get('/debtors/980190962')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/debtor_one_get_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'

    get('/debtors/298486374')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read Rails.root + 'test/static/response/debtor_two_get_form.txt').to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "should be able to save a debtor" do
    _debtorJson = {'debtor': {'name': 'some valid name', 'village': 'some valid village', 'phone': '3001234567'}}
    assert_difference('Debtor.count') do
      post '/debtors', params: _debtorJson
    end

    assert_response :redirect
  end

  test "should not save debtor without name" do
    _articleInvalidJson = {'cost': 55, 'package_quantity': 300, 'availabe_units': 150, 'mrp': 252}
    article = Article.new _articleInvalidJson
    assert_not article.save, "Saved the article without a title"
  end
end
