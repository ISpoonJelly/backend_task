class AddBugIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :bugs, [:appToken, :number]
  end
end
