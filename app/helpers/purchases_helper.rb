# frozen_string_literal: true

module PurchasesHelper
  include ArticlesHelper

  def save_new_purchase_order(purchase)
    Purchase.transaction do
      purchase.save
      Article.transaction do
        purchase.purchase_items.each { |item| update_article_from_purchase_item(item) }
      end
    end
  end
end
