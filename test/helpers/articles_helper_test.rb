# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class ArticlesHelperTest < ActiveSupport::TestCase
  include ArticlesHelper

  setup do
    @article = Article.new(name: 'some valid name', cost: 100, package_quantity: '50 KG', availabe_units: 100, mrp: 250)
    @article.save

    @purchase_item = PurchaseItem.new(article_id: @article.id, price: 200, quantity: 100, cost: 20000)
  end

  teardown do
    @article.delete
  end

  test "should update the article based on purchase item" do
    update_article_from_purchase_item(@purchase_item)

    @article = Article.find(@article.id)

    assert_equal 200, @article.availabe_units
    assert_equal 150, @article.cost

    assert_equal 'some valid name', @article.name
    assert_equal '50 KG', @article.package_quantity
    assert_equal 250, @article.mrp

    @purchase_item = PurchaseItem.new(article_id: @article.id, price: 200, quantity: 200, cost: 40000)

    update_article_from_purchase_item(@purchase_item)

    @article = Article.find(@article.id)

    assert_equal 400, @article.availabe_units
    assert_equal 175, @article.cost

    assert_equal 'some valid name', @article.name
    assert_equal '50 KG', @article.package_quantity
    assert_equal 250, @article.mrp
  end
end
