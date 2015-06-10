class RenamePetOutfits < ActiveRecord::Migration
  def change
    rename_table :pet_outfits, :outfits
  end
end
