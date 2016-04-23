class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :image
      t.integer :for
      t.string :from
      t.integer :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
