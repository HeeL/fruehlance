class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :source
      t.string :title
      t.text :desc
      t.date :posted_at

      t.timestamps
    end
  end
end
