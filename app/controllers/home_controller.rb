class HomeController < ApplicationController
  def home
    @cash_sales = Sale.where('created_at > ?', Date.current.at_beginning_of_day).where(nature: 'CASH')
    @credit_sales = Sale.where('created_at > ?', Date.current.at_beginning_of_day).where(nature: 'CREDIT')
  end
end