class Review < ApplicationRecord
  validates :content, presence: true 
  belongs_to :user
  belongs_to :product
  has_many :pictures
  accepts_nested_attributes_for :pictures
end
