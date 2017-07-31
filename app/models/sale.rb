class Sale < ApplicationRecord
  has_many :sale_items, :dependent => :destroy
  belongs_to :debtor
end
