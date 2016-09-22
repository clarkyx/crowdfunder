class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.belongs_to :project, foreign_key: true

      t.timestamps
    end
  end
end
