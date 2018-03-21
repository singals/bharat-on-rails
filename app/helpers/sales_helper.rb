# frozen_string_literal: true

module SalesHelper
  include ArticlesHelper
  include ProfitAndLossAccountsHelper

  def save_new_sales_order(sale)
    return unless ((sale.nature == 'CREDIT') && !sale.debtor_id.nil?) || sale.nature == 'CASH'
    Sale.transaction do
      default_to_debtor_village_phone(sale) if sale.nature == 'CREDIT'
      sale.save
      Article.transaction do
        profit = update_article_and_calculate_profit(sale)
        ProfitAndLossAccount.transaction do
          pl_record = update_pl(profit, sale)
          pl_record.save
        end
      end
    end
  end

  private

  def update_pl(profit, sale)
    latest_pl_record = ProfitAndLossAccount.last
    new_balance = latest_pl_record.current_balance + profit
    ProfitAndLossAccount.new(description: 'From sale ' + sale.id.to_s, amount: profit,
                             current_balance: new_balance, financial_year: generate_current_financial_year)
  end

  def update_article_and_calculate_profit(sale)
    profit = 0
    sale.sale_items.each do |item|
      article = update_article_from_sale_item(item)
      profit += (item.quantity * (item.price - article.cost)) unless article.nil?
    end
    profit
  end

  def default_to_debtor_village_phone(sale)
    debtor = Debtor.find(sale.debtor_id)
    sale.village = debtor.village
    sale.phone = debtor.phone
  end
end
