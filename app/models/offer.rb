class Offer < ActiveRecord::Base

  SOURCES = [:odesk]

  scope :newest, -> {order(posted_at: :desc)}

  def self.search(params)
    @params = params || {}
    offers = Offer
    offers = add_query_condition if @params[:query]
    offers.newest
  end

  private

  def self.add_query_condition
    q = "%#{@params[:query]}%"
    where("offers.title ILIKE ? OR offers.desc ILIKE ?", q, q)
  end

end
