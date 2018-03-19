# frozen_string_literal: true

module SalesHelper
  include ArticlesHelper
  include ProfitAndLossAccountsHelper

  def save_new_sales_order(sale)
    Sale.transaction do
      sale.save
      Article.transaction do
        profit = 0
        sale.sale_items.each do |item|
          article = update_article_from_sale_item(item)
          profit += (item.quantity * (item.price - article.cost)) unless article.nil?
        end
        ProfitAndLossAccount.transaction do
          latest_pl_record = ProfitAndLossAccount.last
          new_balance = latest_pl_record.current_balance + profit
          pl_record = ProfitAndLossAccount.new(description: 'From sale ' + sale.id.to_s,
                                               amount: profit, current_balance: new_balance, financial_year: get_financial_year)
          pl_record.save
        end
      end
    end
  end
end
