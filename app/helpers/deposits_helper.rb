# frozen_string_literal: true

module DepositsHelper
  include ProfitAndLossAccountsHelper

  def save_deposit(deposit)
    operation_successful = false
    Deposit.transaction do
      operation_successful = deposit.save
      deposit_for_settlement = deposit.mark_settled
      deposit_for_settlement = false if deposit_for_settlement.nil?

      if deposit_for_settlement && operation_successful
        calculate_and_save_profit_loss(deposit)
        operation_successful = settle_deposits_and_sales_for_debtor(deposit, operation_successful)
      end
    end
    operation_successful
  end

  def calculate_and_save_profit_loss(deposit)
    pnl = 0

    unsettled_deposits = Deposit.where(debtor_id: deposit.debtor_id, is_settled: [false, nil])
    unsettled_deposits.each do |unsettled_deposit|
      pnl += unsettled_deposit.amount
    end

    unsettled_sales = Sale.where(debtor_id: deposit.debtor_id, is_settled: [false, nil])
    unsettled_sales.each do |sale|
      pnl -= sale.total_amount
    end

    return if pnl.zero?

    ProfitAndLossAccount.transaction do
      latest_pl_record = ProfitAndLossAccount.last
      new_balance = latest_pl_record.current_balance + pnl
      pnl_new = ProfitAndLossAccount.new(description: 'From debtor settlement - deposit #' + deposit.id.to_s, amount: pnl,
                                         current_balance: new_balance, financial_year: generate_current_financial_year)
      pnl_new.save
    end
  end

  private

  def settle_deposits_and_sales_for_debtor(deposit, operation_successful)
    Sale.transaction do
      sales_to_settle = Sale.where(debtor_id: deposit.debtor_id, is_settled: [false, nil])
      sales_to_settle.each do |sale|
        operation_successful &&= Sale.update(sale.id, is_settled: true)
      end
    end
    Deposit.transaction do
      deposits_to_settle = Deposit.where(debtor_id: deposit.debtor_id, is_settled: [false, nil])
      deposits_to_settle.each do |temp_deposit|
        operation_successful &&= Deposit.update(temp_deposit.id, is_settled: true)
      end
    end
    operation_successful
  end
end
