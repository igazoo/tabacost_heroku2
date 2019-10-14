class Tabaco < ApplicationRecord
  
  has_many :users
  has_many :histories
end
