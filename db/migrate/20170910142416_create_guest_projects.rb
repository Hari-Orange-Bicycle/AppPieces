class CreateGuestProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :guest_projects do |t|
      t.integer :guest_id
      t.integer :project_id

      t.timestamps
    end
  end
end
