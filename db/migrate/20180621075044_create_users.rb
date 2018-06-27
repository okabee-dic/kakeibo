class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|

      t.timestamps
      
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.integer :sex
      t.date :birth
    end
    
    add_index :users, :email, unique: true
  end
end
