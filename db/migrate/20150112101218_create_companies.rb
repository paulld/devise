class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|

      t.string :name
      t.string :symbol
      t.string :stock_exchange

      t.timestamps
    end
  end
end
