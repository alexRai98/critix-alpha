class AddParentIdToGame < ActiveRecord::Migration[6.0]
  def change
    add_reference :games, :parent, index: true
    add_foreign_key :games, :games, column: :parent_id
  end
end
