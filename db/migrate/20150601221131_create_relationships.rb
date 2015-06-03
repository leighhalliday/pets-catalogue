class CreateRelationships < ActiveRecord::Migration
  def change
    change_table :pets do |t|
      t.references :user
    end
  end
end
