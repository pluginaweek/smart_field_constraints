class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :id => false do |t|
      t.integer :id, :limit => 4, :null => false # For limit for testing purposes
      t.string :login, :limit => 12
      t.string :password, :limit => 16
      t.text :biography
    end
  end
  
  def self.down
    drop_table :users
  end
end
