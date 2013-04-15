class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.decimal :price, precision: 8, scale: 2
      t.datetime :date
      t.string :description

      t.timestamps
    end
  end
end
