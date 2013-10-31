every 5.minutes do
  runner "Offer.import!"
end

every 15.days do
  runner "Offer.delete_old!"
end

every 1.month do
  runner "ImportStat.delete_old!"
end
