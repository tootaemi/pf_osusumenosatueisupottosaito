class Bookmark < ApplicationRecord
  validates :post_id, presence: true
  validates :customer_id, uniqueness: { scope: :post_id }

  belongs_to :post
  belongs_to :customer, optional: true

  def bookmarks(customer)
    bookmarks.where(customer_id: customer.id).exists?
  end

  def bookmarked_by?(customer)
    bookmarks.exists?(customer_id: customer.id)
  end
end
