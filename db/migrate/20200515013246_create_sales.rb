class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.datetime :date
      t.integer :quantidade
      t.string :total
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
