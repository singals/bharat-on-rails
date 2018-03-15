# frozen_string_literal: true

module SalesHelper
  include ArticlesHelper

  def save_new_sales_order(sale)
    Sale.transaction do
      sale.save
      Article.transaction do
        sale.sale_items.each { |item| update_article_from_sale_item(item) }
      end
    end
  end
end
