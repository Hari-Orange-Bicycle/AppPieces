class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :message
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :commenter_id
      t.string :commenter_type

      t.timestamps
    end
  end
end
