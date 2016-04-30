class AddRemoveToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :remove, :boolean
  end
end