class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.belongs_to :region, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
