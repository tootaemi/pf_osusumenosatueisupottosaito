class Comment < ApplicationRecord
  
#   validates :start_time, presence: true
   #validates :end_date, presence: true
# validates :strftime, presence: true
   
   validates :comment,presence: true
   
    belongs_to :post#, optional: true
    belongs_to :customer



end
