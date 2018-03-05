class PurchaseItem < ApplicationRecord
  belongs_to :article
  belongs_to :purchase

  validates :article_id, presence: true
end
