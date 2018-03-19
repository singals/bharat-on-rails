# frozen_string_literal: true

module ProfitAndLossAccountsHelper
  def get_financial_year
    @months_in_next_year = 4..12
    @months_in_current_year = 1..3
    today = Date.today.to_s
    tokens = today.split('-')
    year = tokens[0].to_i
    month = tokens[1].to_i

    if @months_in_current_year.include?(month)
      prev_year = year - 1
      return prev_year.to_s + '-' + year.to_s
    elsif @months_in_next_year.include?(month)
      next_year = year + 1
      return year.to_s + '-' + next_year.to_s
    end
  end
end
