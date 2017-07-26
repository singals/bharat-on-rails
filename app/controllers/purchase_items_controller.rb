class PurchaseItemsController < ApplicationController
  before_action :set_purchase
  # before_action :set_purchase_item, only: [:show, :edit, :update, :destroy]

  # GET /purchase_items
  # GET /purchase_items.json
  # def index
  #   @purchase_items = PurchaseItem.all
  # end

  # GET /purchase_items/1
  # GET /purchase_items/1.json
  def show
    @article = Article.find(purchase_items_params[article_id])
  end

  # GET /purchase_items/new
  # def new
  #   @purchase_item = PurchaseItem.new
  # end

  # GET /purchase_items/1/edit
  # def edit
  # end

  # POST /purchase_items
  # POST /purchase_items.json
  def create
    # add new purchase_item
    @purchase.purchase_items.create! purchase_items_params

    # update existing total-cost of the purchase entity
    actual_total_cost = 0
    @purchase.purchase_items.each do |item|
      actual_total_cost += item.cost
    end
    Purchase.update(@purchase.id, :total_cost => actual_total_cost)

    # TODO : update articles qty & average cost

    redirect_to @purchase
  end


  # def create
  #   @purchase_item = PurchaseItem.new(purchase_item_params)
  #
  #   respond_to do |format|
  #     if @purchase_item.save
  #       format.html { redirect_to @purchase_item, notice: 'Purchase item was successfully created.' }
  #       format.json { render :show, status: :created, location: @purchase_item }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @purchase_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /purchase_items/1
  # PATCH/PUT /purchase_items/1.json
  # def update
  #   respond_to do |format|
  #     if @purchase_item.update(purchase_item_params)
  #       format.html { redirect_to @purchase_item, notice: 'Purchase item was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @purchase_item }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @purchase_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /purchase_items/1
  # DELETE /purchase_items/1.json
  # def destroy
  #   @purchase_item.destroy
  #   respond_to do |format|
  #     format.html { redirect_to purchase_items_url, notice: 'Purchase item was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   Use callbacks to share common setup or constraints between actions.
    # def set_purchase_item
    #   @purchase_item = PurchaseItem.find(params[:id])
    # end
    #
    # Never trust parameters from the scary internet, only allow the white list through.
    # def purchase_item_params
    #   params.require(:purchase_item).permit(:article_id, :purchase_id, :quantity, :price, :cost)
    # end

  private
  def set_purchase
    @purchase = Purchase.find(params[:purchase_id])
  end

  def purchase_items_params
    params.required(:purchase_item).permit(:article_id, :purchase_id, :quantity, :price, :cost)
  end
end
