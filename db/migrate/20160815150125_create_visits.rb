class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :link_id
      
      t.timestamps null: false
    end
  end
end
