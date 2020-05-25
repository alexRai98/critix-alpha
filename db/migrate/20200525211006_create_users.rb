class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :unsername
      t.string :email
      t.date :brith_date
      t.integer :review_count

      t.timestamps
    end
  end
end
