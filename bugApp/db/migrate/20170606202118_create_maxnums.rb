class CreateMaxnums < ActiveRecord::Migration[5.1]
  def change
    create_table :maxnums do |t|
      t.string :appToken
      t.integer :max

      t.timestamps
    end
  end
end
