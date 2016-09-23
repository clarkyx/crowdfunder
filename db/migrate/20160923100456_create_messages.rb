class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :infomation
      t.integer :messagetoid
      t.string :messagetotype
      t.integer :user_id

      t.timestamps
    end
  end
end
