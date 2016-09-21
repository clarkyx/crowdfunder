class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
