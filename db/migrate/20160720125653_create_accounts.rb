class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.text :title
      t.string :username
      t.string :password
      t.text :url

      t.timestamps null: false
    end
  end
end
