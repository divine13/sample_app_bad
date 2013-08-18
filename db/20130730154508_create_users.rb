class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name #IT TAKES A HASH AS ARGS 
      t.string :email
      t.timestamps
    end
  end
end
