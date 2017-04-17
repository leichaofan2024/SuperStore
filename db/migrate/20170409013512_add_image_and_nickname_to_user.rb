class AddImageAndNicknameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :image, :string 
  end
end
