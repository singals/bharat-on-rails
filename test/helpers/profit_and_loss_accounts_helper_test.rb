# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class ProfitAndLossAccountHelperTest < ActiveSupport::TestCase
  include ProfitAndLossAccountsHelper

  test "should return the financial year" do
    financial_year = nil
    Date.stub :today, Date.new(2018, 3, 31) do
      financial_year = generate_current_financial_year
    end

    assert_equal '2017-2018', financial_year

    Date.stub :today, Date.new(2018, 4, 1) do
      financial_year = generate_current_financial_year
    end

    assert_equal '2018-2019', financial_year

    Date.stub :today, Date.new(2017, 11, 18) do
      financial_year = generate_current_financial_year
    end

    assert_equal '2017-2018', financial_year
  end
end
