class Product < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites , source: :user
  mount_uploader :image, ImageUploader

  def add_to_favorite!(user)
    self.users << user
    self.save
  end

  def quit_favorite!(user)
    self.users.delete(user)
    self.save
  end


end
