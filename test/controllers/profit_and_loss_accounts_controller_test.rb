# frozen_string_literal: true

require 'test_helper'

class ProfitAndLossAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profit_and_loss_account = profit_and_loss_accounts(:one)
  end

  # custom
  test "should be able to create an P&L entry for Profit" do
    post'/profit_and_loss_accounts', :params => {:profit_and_loss_account => {:description =>'Test', :amount => '100',
                                                        :current_balance => '100', :financial_year => '2017-2018'}}

    assert_response :redirect
    @latest_pl = ProfitAndLossAccount.order('created_at').last

    assert_equal 'Test', @latest_pl.description, "Description does not match"
    assert_equal 100, @latest_pl.amount, "Amount does not match"
    assert_equal 100, @latest_pl.current_balance, "Current balance does not match"
    assert_equal '2017-2018', @latest_pl.financial_year, "Financial year does not match"
  end

  test "should be able to create an P&L entry for Loss" do
    post '/profit_and_loss_accounts', :params => {:profit_and_loss_account => {:description =>'Test return', :amount => '-100',
                                                                              :current_balance => '0', :financial_year => '2017-2018'}}

    assert_response :redirect
    @latest_pl = ProfitAndLossAccount.order('created_at').last

    assert_equal 'Test return', @latest_pl.description, "Description does not match"
    assert_equal -100, @latest_pl.amount, "Amount does not match"
    assert_equal 0, @latest_pl.current_balance, "Current balance does not match"
    assert_equal '2017-2018', @latest_pl.financial_year, "Financial year does not match"
  end

  test "should be able to delete an P&L entry for Loss" do
    # Create a temporary P&L record
    post '/profit_and_loss_accounts', :params => {:profit_and_loss_account => {:description =>'Test return', :amount => '-100',
                                                                               :current_balance => '0', :financial_year => '2017-2018'}}

    assert_response :redirect
    @latest_pl = ProfitAndLossAccount.order('created_at').last

    # Invoke delete API
    delete '/profit_and_loss_accounts/' + @latest_pl.id.to_s
    assert_response :redirect

    assert_empty ProfitAndLossAccount.where(id: @latest_pl.id), "P&L record must've been deleted"
  end

  test "should be able to edit an P&L entry for Loss" do
    # Create a temporary P&L record
    post '/profit_and_loss_accounts', :params => {:profit_and_loss_account => {:description =>'Test return', :amount => '-100',
                                                                               :current_balance => '0', :financial_year => '2017-2018'}}
    assert_response :redirect
    @latest_pl = ProfitAndLossAccount.order('created_at').last

    # Edit the newly created P&L record
    put '/profit_and_loss_accounts/' + @latest_pl.id.to_s,
        :params => {:profit_and_loss_account => {:description =>'Updated description', :amount => '100',
                                                                                                      :current_balance => '100', :financial_year => '2018-2019'}}
    assert_response :redirect
    @latest_pl = ProfitAndLossAccount.order('created_at').last

    assert_equal 'Updated description', @latest_pl.description, "Description does not match"
    assert_equal 100, @latest_pl.amount, "Amount does not match"
    assert_equal 100, @latest_pl.current_balance, "Current balance does not match"
    assert_equal '2018-2019', @latest_pl.financial_year, "Financial year does not match"
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
