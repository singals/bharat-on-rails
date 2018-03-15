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

  test "shall save new sale order and adjust article's stock and cost" do
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
end
