class AddCategoryIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :category_id, :integer
  end
end
