class AddPublicShareTokenToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :public_share_token, :string
    add_column :cards, :slug, :string
    add_index :cards, :slug, unique: true
  end
end
