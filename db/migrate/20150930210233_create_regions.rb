class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.belongs_to :country, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
