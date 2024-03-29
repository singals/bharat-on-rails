# frozen_string_literal: true

class DepositsController < ApplicationController
  include DepositsHelper
  before_action :set_deposit, only: [:show, :edit, :update, :destroy]

  # GET /deposits
  # GET /deposits.json
  def index
    @deposits = Deposit.all
  end

  # GET /deposits/1
  # GET /deposits/1.json
  def show
    # @transaction_nature = ['From Debtor', 'To creditor']
    @transaction_nature = ['From Debtor']
    @debtors = Debtor.where(is_active: true)
  end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
    # @transaction_nature = ['From Debtor', 'To creditor']
    @transaction_nature = ['From Debtor']
    @debtors = Debtor.where(is_active: true)
  end

  # GET /deposits/1/edit
  def edit
    # @transaction_nature = ['From Debtor', 'To creditor']
    @transaction_nature = ['From Debtor']
    @debtors = Debtor.where(is_active: true)
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)

    respond_to do |format|
      if save_deposit(@deposit)
        format.html { redirect_to @deposit, notice: 'Deposit was successfully created.' }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html render :new,
                           locals: { :@deposit => Deposit.new, :@transaction_nature => ['From Debtor'], :@debtors => Debtor.where(is_active: true) }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1
  # PATCH/PUT /deposits/1.json
  def update
    respond_to do |format|
      #TODO: allow for mark_settled=false && is_settled=false only
      if @deposit.update(deposit_params)
        format.html { redirect_to @deposit, notice: 'Deposit was successfully updated.' }
        format.json { render :show, status: :ok, location: @deposit }
      else
        format.html { render :edit }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits/1
  # DELETE /deposits/1.json
  def destroy
    @deposit.destroy
    #TODO: allow for mark_settled=false && is_settled=false only
    respond_to do |format|
      format.html { redirect_to deposits_url, notice: 'Deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deposit
    @deposit = Deposit.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def deposit_params
    params.require(:deposit).permit(:nature, :amount, :debtor_id, :mark_settled, :is_settled)
  end
end
