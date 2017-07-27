class PurchaseItemsController < ApplicationController
  before_action :set_purchase
  before_action :set_purchase_item, only: [:destroy]

  # GET /purchase_items/1
  # GET /purchase_items/1.json
  def show
    @article = Article.find(purchase_items_params[article_id])
  end

  # POST /purchase_items
  # POST /purchase_items.json
  def create
    purchase_item_created = purchase_items_params
    @purchase.purchase_items.create! purchase_item_created

    update_total_cost_of_purchase

    update_article_quantity_and_cost(purchase_item_created)

    redirect_to @purchase
  end

  # DELETE /purchase_items/1
  def destroy
    @purchase_item.destroy
    redirect_to @purchase
  end


  private
  def set_purchase
    @purchase = Purchase.find(params[:purchase_id])
  end

  def set_purchase_item
    @purchase_item = PurchaseItem.find(purchase_items_params_on_delete[:id].to_i)
  end

  def purchase_items_params
    params.required(:purchase_item).permit(:article_id, :purchase_id, :quantity, :price, :cost)
  end

  def purchase_items_params_on_delete
    params.permit(:article_id, :purchase_id, :quantity, :price, :cost, :id)
  end

  def update_article_quantity_and_cost(purchase_item_created)
    article_id = purchase_item_created[:article_id]
    article = Article.find(article_id)

    # calculate article's new quantity
    added_quantity = purchase_item_created[:quantity].to_i
    existing_quantity = article.availabe_units
    new_quantity = existing_quantity + added_quantity

    # calculate article's new average cost
    existing_average_cost = article.cost
    article_existing_worth = existing_quantity * existing_average_cost
    new_average_cost = (article_existing_worth + purchase_item_created[:cost].to_f)/
        (existing_quantity + added_quantity)

    Article.update(article_id, :availabe_units => new_quantity, :cost => new_average_cost)
  end

  def update_total_cost_of_purchase
    actual_total_cost = 0
    @purchase.purchase_items.each do |item|
      actual_total_cost += item.cost
    end

    Purchase.update(@purchase.id, :total_cost => actual_total_cost)
  end
end
