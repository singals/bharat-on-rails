# frozen_string_literal: true

require 'test_helper'

class DepositsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deposit = deposits(:one)
  end

  # customised tests
  test "shall be able to get a deposit by id" do
    get('/deposits/980190962')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read(Rails.root + 'test/static/response/deposit_one_get_form.txt')).to_text
    assert_equal expected_response, actual_response, 'response does not match'

    get('/deposits/298486374')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read(Rails.root + 'test/static/response/deposit_two_get_form.txt')).to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "shall be able to get all deposit" do
    get('/deposits')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read(Rails.root + 'test/static/response/deposit_get_all_form.txt')).to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  # auto-generated
  test "should get index" do
    get deposits_url
    assert_response :success
  end

  test "should get new" do
    get new_deposit_url
    assert_response :success
  end

  test "should create deposit" do
    assert_difference('Deposit.count') do
      post deposits_url, params: { deposit: { amount: @deposit.amount, debtor_id: @deposit.debtor_id, nature: @deposit.nature } }
    end

    assert_redirected_to deposit_url(Deposit.last)
  end

  test "should show deposit" do
    get deposit_url(@deposit)
    assert_response :success
  end

  test "should get edit" do
    get edit_deposit_url(@deposit)
    assert_response :success
  end

  test "should update deposit" do
    patch deposit_url(@deposit), params: { deposit: { amount: @deposit.amount, debtor_id: @deposit.debtor_id, nature: @deposit.nature } }
    assert_redirected_to deposit_url(@deposit)
  end

  test "should destroy deposit" do
    assert_difference('Deposit.count', -1) do
      delete deposit_url(@deposit)
    end

    assert_redirected_to deposits_url
  end
end
