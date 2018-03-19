# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class SalesHelperTest < ActiveSupport::TestCase
  include SalesHelper

  setup do
    @article1 = Article.new(name: 'Article 1', cost: 100, package_quantity: '50 KG', availabe_units: 100, mrp: 135)
    @article1.save

    @article2 = Article.new(name: 'Article 2', cost: 200, package_quantity: '10 KG', availabe_units: 50, mrp: 260)
    @article2.save

    @sale_item1 = SaleItem.new(article_id: @article1.id, price: 120, quantity: 10, amount: 1_200)
    @sale_item2 = SaleItem.new(article_id: @article2.id, price: 230, quantity: 20, amount: 4_600)
    @sale = Sale.new(nature: 'CASH', village: 'Kurukshetra', phone: '9876543210', total_amount: 5_800)
    @sale.sale_items = [@sale_item1, @sale_item2]
  end

  test "shall save new sale order and adjust article's stock" do
    save_new_sales_order(@sale)

    @actual_article1 = Article.find(@article1.id)
    assert_equal 90, @actual_article1.availabe_units # 100-10
    assert_equal 100, @actual_article1.cost
    assert_equal 'Article 1', @actual_article1.name
    assert_equal '50 KG', @actual_article1.package_quantity
    assert_equal 135, @actual_article1.mrp

    @actual_article2 = Article.find(@article2.id)
    assert_equal 30, @actual_article2.availabe_units # 50-20
    assert_equal 200, @actual_article2.cost
    assert_equal 'Article 2', @actual_article2.name
    assert_equal '10 KG', @actual_article2.package_quantity
    assert_equal 260, @actual_article2.mrp
  end

  test "shall save new sale order and adjust profit and loss" do
    initial_pnl_balance = ProfitAndLossAccount.last.current_balance
    save_new_sales_order(@sale)

    latest_sale = Sale.last
    assert_equal latest_sale.nature, 'CASH'
    assert_equal latest_sale.village, 'Kurukshetra'
    assert_equal latest_sale.phone, '9876543210'
    assert_equal latest_sale.total_amount, 5_800
    assert_equal latest_sale.sale_items.size, 2

    latest_pnl_record = ProfitAndLossAccount.last

    assert_equal initial_pnl_balance + 200 + 600, latest_pnl_record.current_balance
    assert_equal 'From sale ' + @sale.id.to_s, latest_pnl_record.description
    assert_equal 800, latest_pnl_record.amount
    assert_not_empty latest_pnl_record.financial_year
  end
end
