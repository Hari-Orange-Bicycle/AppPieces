class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.string :file_name
      t.string :file_type
      t.string :file_source
      t.string :file_link
      t.references :card

      t.timestamps
    end
  end
end
