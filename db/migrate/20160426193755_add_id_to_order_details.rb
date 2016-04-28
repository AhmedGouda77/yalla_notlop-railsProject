class AddIdToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :id, :primary_key
  end
end
