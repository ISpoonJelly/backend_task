class CreateBugs < ActiveRecord::Migration[5.1]
  def change
    create_table :bugs do |t|
      t.string :appToken
      t.integer :number
      t.integer :status
      t.integer :priority
      t.string :comment
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
