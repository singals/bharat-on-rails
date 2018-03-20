# frozen_string_literal: true

class Deposit < ApplicationRecord
  validates :nature, presence: true
  validates :debtor, presence: true
  validates :amount, presence: true

  belongs_to :debtor
end
