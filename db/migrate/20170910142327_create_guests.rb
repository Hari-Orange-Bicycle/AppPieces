class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :full_name
      t.string :email

      t.timestamps
    end
  end
end
