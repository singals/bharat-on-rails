# frozen_string_literal: true

module DepositsHelper
  def save_deposit(deposit)
    operation_successful = false
    Deposit.transaction do
      operation_successful = deposit.save
      deposit_for_settlement = deposit.mark_settled
      deposit_for_settlement = false if deposit_for_settlement.nil?
      if deposit_for_settlement && operation_successful
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
      end
    end
    operation_successful
  end
end
