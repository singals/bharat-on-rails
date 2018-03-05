require 'test_helper'

class ProfitAndLossAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profit_and_loss_account = profit_and_loss_accounts(:one)
  end


  # auto-generated
  test "should get index" do
    get profit_and_loss_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_profit_and_loss_account_url
    assert_response :success
  end

  test "should create profit_and_loss_account" do
    assert_difference('ProfitAndLossAccount.count') do
      post profit_and_loss_accounts_url, params: { profit_and_loss_account: { amount: @profit_and_loss_account.amount, current_balance: @profit_and_loss_account.current_balance, description: @profit_and_loss_account.description, financial_year: @profit_and_loss_account.financial_year } }
    end

    assert_redirected_to profit_and_loss_account_url(ProfitAndLossAccount.last)
  end

  test "should show profit_and_loss_account" do
    get profit_and_loss_account_url(@profit_and_loss_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_profit_and_loss_account_url(@profit_and_loss_account)
    assert_response :success
  end

  test "should update profit_and_loss_account" do
    patch profit_and_loss_account_url(@profit_and_loss_account), params: { profit_and_loss_account: { amount: @profit_and_loss_account.amount, current_balance: @profit_and_loss_account.current_balance, description: @profit_and_loss_account.description, financial_year: @profit_and_loss_account.financial_year } }
    assert_redirected_to profit_and_loss_account_url(@profit_and_loss_account)
  end

  test "should destroy profit_and_loss_account" do
    assert_difference('ProfitAndLossAccount.count', -1) do
      delete profit_and_loss_account_url(@profit_and_loss_account)
    end

    assert_redirected_to profit_and_loss_accounts_url
  end
end
