# frozen_string_literal: true

class SaleItemsController < ApplicationController
  # before_action :set_sale
  # before_action :set_sale_item, only: [:destroy]

  # # POST /sale_items
  # # POST /sale_items.json
  # def create
  #   others = OP_TYPE::OTHERS
  #   sale_item_created = sale_items_params(others)
  #   @sale.sale_items.create! sale_item_created
  #
  #   update_total_cost_of_sale
  #
  #   update_article_quantity(sale_item_created, others)
  #
  #   redirect_to @sale
  # end

  # DELETE /sale_items/1
  # def destroy
  #   @sale_item.destroy
  #
  #   delete = OP_TYPE::DELETE
  #   update_total_cost_of_sale
  #   update_article_quantity(sale_items_params(delete), delete)
  #
  #   # TODO adjust stock and P&L account
  #
  #   redirect_to @sale
  # end


  # private
  # def set_sale
  #   @sale = Sale.find(params[:sale_id])
  # end
  #
  # def set_sale_item
  #   @sale_item = SaleItem.find(sale_items_params(OP_TYPE::DELETE)[:id].to_i)
  # end
  #
  # def sale_items_params(op_type)
  #   if op_type == OP_TYPE::DELETE
  #     params.permit(:article_id, :purchase_id, :quantity, :price, :amount, :id)
  #   elsif op_type == OP_TYPE::OTHERS
  #     params.required(:sale_item).permit(:article_id, :purchase_id, :quantity, :price, :amount)
  #   end
  # end
  #
  # def update_article_quantity(sale_item, op_type)
  #   if op_type == OP_TYPE::DELETE
  #     article_id = @sale_item.article_id
  #   elsif op_type == OP_TYPE::OTHERS
  #     article_id = sale_item[:article_id]
  #   end
  #   article = Article.find(article_id)
  #
  #   # calculate article's new quantity
  #   item_quantity = sale_item[:quantity].to_i
  #   existing_quantity = article.availabe_units
  #   new_quantity = existing_quantity
  #   if op_type == OP_TYPE::DELETE
  #     new_quantity = existing_quantity + item_quantity
  #   elsif op_type == OP_TYPE::OTHERS
  #     new_quantity = existing_quantity - item_quantity
  #   end
  #
  #   Article.update(article_id, :availabe_units => new_quantity)
  # end
  #
  # def update_total_cost_of_sale()
  #   actual_total_amount = 0
  #   @sale.sale_items.each do |item|
  #     actual_total_amount += item.amount
  #   end
  #
  #   Sale.update(@sale.id, :total_amount => actual_total_amount)
  # end
  #
  # module OP_TYPE
  #   DELETE = "DELETE"
  #   OTHERS = "OTHERS"
  # end
end
