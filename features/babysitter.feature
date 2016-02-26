Feature: As a babysitter
In order to get paid for 1 night of work
I want to calculate my nightly charge

  Scenario: Calculate pay for 1 night of work
  Given I babysit from 17 to 28
  Then I get paid 140

  Scenario: Calculate pay and for full fractional hours
  Given I babysit from 17.5 to 27.3
  Then I get paid 112