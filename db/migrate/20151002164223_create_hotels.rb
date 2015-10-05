class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.belongs_to :city, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
