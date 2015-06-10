class CreatePetOutfits < ActiveRecord::Migration
  def change
    create_table :pet_outfits do |t|
      t.integer :pet_id, null: false
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
