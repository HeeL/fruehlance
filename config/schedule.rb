every 10.minutes do
  runner "Offer.import!"
end

every 1.week do
  runner "Offer.delete_old!"
end

every 1.month do
  runner "ImportStat.delete_old!"
end
