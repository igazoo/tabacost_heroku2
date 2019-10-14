class History < ApplicationRecord
   validates :tabaco_id,presence: true
   validates :price,presence: true
   
   belongs_to :user
   belongs_to :tabaco
   
  
end
