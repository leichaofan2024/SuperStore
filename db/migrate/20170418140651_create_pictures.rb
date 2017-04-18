class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.integer :review_id
      t.string :avatar

      t.timestamps
    end
  end
end
