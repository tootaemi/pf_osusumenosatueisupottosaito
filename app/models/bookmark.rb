class Bookmark < ApplicationRecord
  
      belongs_to :post, optional: true
      belongs_to :customer

end
