class AddOfferInfoToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :ext_id, :integer
    add_column :offers, :offer_url, :string
  end
end
