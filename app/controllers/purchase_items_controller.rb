class PurchaseItemsController < ApplicationController
  before_action :set_purchase
  before_action :set_purchase_item, only: [:destroy]

  # GET /purchase_items/1
  # GET /purchase_items/1.json
  def show
    @article = Article.find(purchase_items_params(OP_TYPE::OTHERS)[article_id])
  end

  # POST /purchase_items
  # POST /purchase_items.json
  def create
    others = OP_TYPE::OTHERS
    purchase_item_created = purchase_items_params(others)
    @purchase.purchase_items.create! purchase_item_created

    update_total_cost_of_purchase

    update_article_quantity_and_cost(purchase_item_created, others)

    redirect_to @purchase
  end

  # DELETE /purchase_items/1
  def destroy
    @purchase_item.destroy

    delete = OP_TYPE::DELETE
    update_total_cost_of_purchase
    update_article_quantity_and_cost(purchase_items_params(delete), delete)

    redirect_to @purchase
  end


  private
  def set_purchase
    @purchase = Purchase.find(params[:purchase_id])
  end

  def set_purchase_item
    @purchase_item = PurchaseItem.find(purchase_items_params((OP_TYPE::DELETE))[:id].to_i)
  end

  def purchase_items_params(op_type)
    if op_type == OP_TYPE::DELETE
      params.permit(:article_id, :purchase_id, :quantity, :price, :cost, :id)
    elsif op_type == OP_TYPE::OTHERS
      params.required(:purchase_item).permit(:article_id, :purchase_id, :quantity, :price, :cost)
    end
  end

  def update_article_quantity_and_cost(purchase_item, op_type)
    if op_type == OP_TYPE::DELETE
      article_id = @purchase_item.article_id
    elsif op_type == OP_TYPE::OTHERS
      article_id = purchase_item[:article_id]
    end
    article = Article.find(article_id)

    # calculate article's new quantity
    item_quantity = purchase_item[:quantity].to_i
    existing_quantity = article.availabe_units
    new_quantity = existing_quantity
    if op_type == OP_TYPE::DELETE
      new_quantity = existing_quantity - item_quantity
    elsif op_type == OP_TYPE::OTHERS
      new_quantity = existing_quantity + item_quantity
    end

    # calculate article's new average cost
    existing_average_cost = article.cost
    article_existing_worth = existing_quantity * existing_average_cost

    new_average_cost = existing_average_cost
    if op_type ==OP_TYPE::DELETE
      new_average_cost = (article_existing_worth - purchase_item[:cost].to_f)/
          (existing_quantity - item_quantity)
    elsif op_type == OP_TYPE::OTHERS
      new_average_cost = (article_existing_worth + purchase_item[:cost].to_f)/
          (existing_quantity + item_quantity)
    end

    Article.update(article_id, :availabe_units => new_quantity, :cost => new_average_cost)
  end

  def update_total_cost_of_purchase()
    actual_total_cost = 0
    @purchase.purchase_items.each do |item|
        actual_total_cost += item.cost
    end

    Purchase.update(@purchase.id, :total_cost => actual_total_cost)
  end

  module OP_TYPE
    DELETE = "DELETE"
    OTHERS = "OTHERS"
  end
end
