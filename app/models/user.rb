class User < ApplicationRecord
  validates :name, presence: true,
                   length: {minimum:3,maximum:10}
                   
  has_secure_password
  
  validates :password, presence: true,
                       length: {minimum:8,maximum:32},
                       format: { with: /\A[a-z0-9]+\z/i }
                       
  belongs_to :tabaco

  has_many :histories
end
