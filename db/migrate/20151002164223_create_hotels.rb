class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.belongs_to :region, index: true, foreign_key: true
      t.belongs_to :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
