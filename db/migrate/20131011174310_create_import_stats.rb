class CreateImportStats < ActiveRecord::Migration
  def change
    create_table :import_stats do |t|
      t.integer :source
      t.integer :imported
      
      t.timestamps
    end
  end
end
