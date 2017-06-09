class ChangeMaxDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :maxnums, :max, :integer, :default => 0
  end
end
