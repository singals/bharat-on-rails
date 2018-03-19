# frozen_string_literal: true

class SalesController < ApplicationController
  include SalesHelper

  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    @articles = Article.where(is_active: true)
    @transaction_nature = ['CASH', 'CREDIT']
    @debtors = Debtor.where(is_active: true)

    @debtors.each do |debtor|
      debtor.name += ' - ' + debtor.village
    end
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @transaction_nature = ['CASH', 'CREDIT']
    @debtors = Debtor.where(is_active: true)
    @articles = Article.where(is_active: true)
    @sale.sale_items.build

    @debtors.each do |debtor|
      debtor.name += ' - ' + debtor.village
    end
  end

  # GET /sales/1/edit
  # def edit
  #   @transaction_nature = ['CASH', 'CREDIT']
  #   @articles = Article.where(is_active: true)
  #   @debtors = Debtor.where(is_active: true)
  #   @sale_items = SaleItem.where(sale_id: params[:id])
  #
  #   @debtors.each do |debtor|
  #     debtor.name += ' - ' + debtor.village
  #   end
  # end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    respond_to do |format|
      if save_new_sales_order(@sale)
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  # def update
  #   # TODO adjust stock and P&L account
  #   # TODO adjust debtor's account for CREDIT sale
  #   respond_to do |format|
  #     if @sale.update(sale_params)
  #       format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @sale }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @sale.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    # TODO adjust stock and P&L account
    # TODO adjust debtor's account for CREDIT sale
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:nature, :debtor_id, :village, :phone, :total_amount,
        sale_items_attributes: [:article_id, :quantity, :price, :amount])
    end
end
