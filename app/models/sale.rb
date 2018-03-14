# frozen_string_literal: true

class Sale < ApplicationRecord
  has_many :sale_items, :dependent => :destroy
  belongs_to :debtor, optional: true

  accepts_nested_attributes_for :sale_items
end
