Given(/^I babysit from (\d+\.?\d+) to (\d+\.?\d+)$/) do |start, endtime|
  @sitting = BabySit.new(start,endtime)
end

Then(/^I get paid (\d+)$/) do |amount|
  @sitting.round_hours
  expect(@sitting.calculate_pay).to eq amount
end
