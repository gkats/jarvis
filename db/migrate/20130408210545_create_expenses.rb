class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.timestamps
    end
  end
end
