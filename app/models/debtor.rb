# frozen_string_literal: true

class Debtor < ApplicationRecord
  validates :name, presence: true

  has_many :sales, dependent: :destroy
  has_many :deposits, dependent: :destroy
end
