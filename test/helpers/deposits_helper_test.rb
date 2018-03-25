# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class DepositsHelperTest < ActiveSupport::TestCase
  include DepositsHelper

  setup do
    @article = Article.new(name: 'some valid name', cost: 100, package_quantity: '50 KG', availabe_units: 100, mrp: 250)
    @article.save
    @debtor = Debtor.new(is_active: true, name: 'Test Debtor', phone: '9876556789', village: 'Test village')
    @debtor.save
    @sale = Sale.new(nature: 'CREDIT', village: 'Test village', phone: '9876556789', total_amount: 10_000, debtor_id: @debtor.id)
    @sale.save
    @deposit1 = Deposit.new(amount: 1_000, debtor_id: @debtor.id, nature: 'From debtor')
    @deposit1.save
    @deposit2 = Deposit.new(amount: 9_500, debtor_id: @debtor.id, nature: 'From debtor', mark_settled: true) # For profit on settlement
    @deposit3 = Deposit.new(amount: 9_000, debtor_id: @debtor.id, nature: 'From debtor') # not for settlement
    @deposit4 = Deposit.new(amount: 8_000, debtor_id: @debtor.id, nature: 'From debtor', mark_settled: true) # For loss on settlement
    @deposit5 = Deposit.new(amount: 9_000, debtor_id: @debtor.id, nature: 'From debtor', mark_settled: true) # Settlement at par
  end

  teardown do
    @deposit1.delete
    @sale.delete
    @debtor.delete
    @article.delete
  end

  test "should save a deposit that's not for a settlement" do
    save_deposit(@deposit3)

    assert_equal @article, Article.find(@article.id)
    assert_equal @debtor, Debtor.find(@debtor.id)
    assert_equal @sale, Sale.find(@sale.id)
    assert_equal @deposit1, Deposit.find(@deposit1.id)
    assert_equal @deposit3, Deposit.last

    @deposit3.delete
  end

  test "should mark sales and deposits as settled on deposit for settlement" do
    save_deposit(@deposit2)

    assert_equal @article, Article.find(@article.id)
    assert_equal @debtor, Debtor.find(@debtor.id)
    assert_equal true, Sale.find(@sale.id).is_settled
    assert_equal true, Deposit.find(@deposit1.id).is_settled
    assert_equal true, Deposit.last.is_settled
    assert_equal true, Deposit.last.mark_settled

    @deposit2.delete
  end

  test "should calculate and persist profit" do
    initial_pnl = ProfitAndLossAccount.last

    save_deposit(@deposit2)

    latest_pnl = ProfitAndLossAccount.last
    assert_equal 500, latest_pnl.amount
    assert_equal initial_pnl.current_balance + 500, latest_pnl.current_balance

    @deposit2.delete
  end

  test "should calculate and persist loss" do
    initial_pnl = ProfitAndLossAccount.last

    save_deposit(@deposit4)

    latest_pnl = ProfitAndLossAccount.last
    assert_equal(-1_000, latest_pnl.amount)
    assert_equal initial_pnl.current_balance - 1_000, latest_pnl.current_balance

    @deposit4.delete
  end

  test "should not add PnL record if there isn't any" do
    initial_pnl = ProfitAndLossAccount.last

    save_deposit(@deposit5)

    latest_pnl = ProfitAndLossAccount.last
    assert_equal initial_pnl, latest_pnl

    @deposit5.delete
  end
end
