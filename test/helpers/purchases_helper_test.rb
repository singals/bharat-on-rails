# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class PurchasesHelperTest < ActiveSupport::TestCase
  include PurchasesHelper

  setup do
    @article1 = Article.new(name: 'Article 1', cost: 100, package_quantity: '50 KG', availabe_units: 100, mrp: 135)
    @article1.save

    @article2 = Article.new(name: 'Article 2', cost: 200, package_quantity: '10 KG', availabe_units: 50, mrp: 260)
    @article2.save

    @purchase_item1 = PurchaseItem.new(article_id: @article1.id, price: 120, quantity: 100, cost: 12_000)
    @purchase_item2 = PurchaseItem.new(article_id: @article2.id, price: 180, quantity: 100, cost: 18_000)
    @purchase = Purchase.new(seller_name: 'test seller', city: 'Kurukshetra', phone: '9876543210', invoice_number: '123', total_cost: 30_000)
    @purchase.purchase_items = [@purchase_item1, @purchase_item2]
  end

  test "shall save new purchase order and adjust article's stock and cost" do
    save_new_purchase_order(@purchase)

    @actual_article1 = Article.find(@article1.id)
    assert_equal 200, @actual_article1.availabe_units # 100+100
    assert_equal 110, @actual_article1.cost # (100*100 + 120*100)/200
    assert_equal 'Article 1', @actual_article1.name
    assert_equal '50 KG', @actual_article1.package_quantity
    assert_equal 135, @actual_article1.mrp

    @actual_article2 = Article.find(@article2.id)
    assert_equal 150, @actual_article2.availabe_units # 50+100
    assert_equal 186.666666666667, @actual_article2.cost # (50*200 + 180*100)/150
    assert_equal 'Article 2', @actual_article2.name
    assert_equal '10 KG', @actual_article2.package_quantity
    assert_equal 260, @actual_article2.mrp
  end
end
