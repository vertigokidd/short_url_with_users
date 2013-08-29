class CreateTables < ActiveRecord::Migration
  def change
  	create_table :links do |t|
  	  t.string :long_url
      t.string :key
  	  t.integer :user_id
  	end

    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password, null: false

      t.timestamps
    end
  end
end
