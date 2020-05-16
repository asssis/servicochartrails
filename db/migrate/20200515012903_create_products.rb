class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :descricao, limit: 50
      t.string :valor
      t.string :codigo, limit: 50

      t.timestamps
    end
  end
end
