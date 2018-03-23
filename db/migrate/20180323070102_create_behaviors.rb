class CreateBehaviors < ActiveRecord::Migration[5.1]
  def change
    create_table :behaviors do |t|
      t.string :name
      t.string :details
      t.integer :type_of_id

      t.timestamps
    end
  end
end
