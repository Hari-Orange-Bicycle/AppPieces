class AddColumnCardsCreatedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cards_created, :integer, default: 0
  end
end
