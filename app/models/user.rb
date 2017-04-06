class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :favorites
  has_many :products, :through => :favorites , source: :product
  has_many :carts, dependent: :destroy 

  def admin?
    is_admin
  end

end
