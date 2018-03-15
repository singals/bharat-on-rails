# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class ArticlesHelperTest < ActiveSupport::TestCase
  include ArticlesHelper

  setup do
    @article = Article.new(name: 'some valid name', cost: 100, package_quantity: '50 KG', availabe_units: 100, mrp: 250)
    @article.save
  end

  teardown do
    @article.delete
  end

  test "should update the article based on purchase item" do
    @purchase_item = PurchaseItem.new(article_id: @article.id, price: 200, quantity: 100, cost: 20_000)
    update_article_from_purchase_item(@purchase_item)

    @article = Article.find(@article.id)

    assert_equal 200, @article.availabe_units
    assert_equal 150, @article.cost

    assert_equal 'some valid name', @article.name
    assert_equal '50 KG', @article.package_quantity
    assert_equal 250, @article.mrp

    @purchase_item = PurchaseItem.new(article_id: @article.id, price: 200, quantity: 200, cost: 40_000)

    update_article_from_purchase_item(@purchase_item)

    @article = Article.find(@article.id)

    assert_equal 400, @article.availabe_units
    assert_equal 175, @article.cost

    assert_equal 'some valid name', @article.name
    assert_equal '50 KG', @article.package_quantity
    assert_equal 250, @article.mrp
  end

  test "should update the article based on sale item" do
    @sale_item = SaleItem.new(article_id: @article.id, quantity: 10, price: 200, amount: 2_000)
    update_article_from_sale_item(@sale_item)

    @article = Article.find(@article.id)

    assert_equal 90, @article.availabe_units
    assert_equal 100, @article.cost

    assert_equal 'some valid name', @article.name
    assert_equal '50 KG', @article.package_quantity
    assert_equal 250, @article.mrp

    @sale_item = SaleItem.new(article_id: @article.id, quantity: 15, price: 210, amount: 3_150)
    update_article_from_sale_item(@sale_item)

    @article = Article.find(@article.id)

    assert_equal 75, @article.availabe_units
    assert_equal 100, @article.cost

    assert_equal 'some valid name', @article.name
    assert_equal '50 KG', @article.package_quantity
    assert_equal 250, @article.mrp
  end
end
