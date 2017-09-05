class AddColumnPublicShareTokenToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :public_share_token, :string
  end
end
