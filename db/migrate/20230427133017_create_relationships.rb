class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :active_follow_id
      t.integer :passive_follow_id

      t.timestamps
    end
  end
end
