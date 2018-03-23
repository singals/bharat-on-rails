# frozen_string_literal: true

class DebtorsController < ApplicationController
  before_action :set_debtor, only: [:show, :edit, :update, :destroy]

  # GET /debtors
  # GET /debtors.json
  def index
    @debtors = Debtor.where(is_active: true)
  end

  # GET /debtors/1
  # GET /debtors/1.json
  def show
    @deposits = Deposit.where(debtor_id: @debtor.id, is_settled: [false, nil])
    @sales = Sale.where(debtor_id: @debtor.id, is_settled: [false, nil])
  end

  # GET /debtors/new
  def new
    @debtor = Debtor.new
  end

  # GET /debtors/1/edit
  def edit; end

  # POST /debtors
  # POST /debtors.json
  def create
    my_params = debtor_params
    active_on_creation = { 'is_active' => true }
    my_params = active_on_creation.merge(my_params)
    @debtor = Debtor.new(my_params)

    respond_to do |format|
      if @debtor.save
        format.html { redirect_to @debtor, notice: 'Debtor was successfully created.' }
        format.json { render :show, status: :created, location: @debtor }
      else
        format.html { render :new }
        format.json { render json: @debtor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debtors/1
  # PATCH/PUT /debtors/1.json
  def update
    respond_to do |format|
      if @debtor.update(debtor_params)
        format.html { redirect_to @debtor, notice: 'Debtor was successfully updated.' }
        format.json { render :show, status: :ok, location: @debtor }
      else
        format.html { render :edit }
        format.json { render json: @debtor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debtors/1
  # DELETE /debtors/1.json
  def destroy
    deactivate_on_deletion = { 'is_active' => false }
    @debtor.update(deactivate_on_deletion)
    respond_to do |format|
      format.html { redirect_to debtors_url, notice: 'Debtor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_debtor
    @debtor = Debtor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def debtor_params
    params.require(:debtor).permit(:name, :village, :phone, :is_active)
  end
end
