# frozen_string_literal: true

module ArticlesHelper
  def update_article_from_purchase_item(purchase_item)
    article = Article.find(purchase_item.article_id)

    current_qty = article.availabe_units
    current_avg_cost = article.cost

    qty_purchased = purchase_item.quantity
    purchase_avg_cost = purchase_item.price

    new_avg = (((current_avg_cost * current_qty) + (qty_purchased * purchase_avg_cost)) / (qty_purchased + current_qty))
    new_qty = qty_purchased + current_qty

    article.update(availabe_units: new_qty, cost: new_avg)
  end
end
