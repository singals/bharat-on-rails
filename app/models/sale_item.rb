class SaleItem < ApplicationRecord
  belongs_to :article
  belongs_to :sale

  validates :article_id, presence: true
  validates :sale_id, presence: true
end
