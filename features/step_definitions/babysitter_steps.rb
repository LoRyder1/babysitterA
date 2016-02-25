Given(/^I babysit from (\d+) to (\d+)/) do |start, endtime|
  @sitting = BabySit.new(start,endtime)
end

Then(/^I get paid (\d+)/) do |amount|
  expect(@sitting.calculate_pay).to eq 140
end
