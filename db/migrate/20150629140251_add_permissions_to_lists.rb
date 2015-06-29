class AddPermissionsToLists < ActiveRecord::Migration
  def change
    add_column :lists, :permission, :string
  end
end
