Feature: As a babysitter
In order to get paid for 1 night of work
I want to calculate my nightly charge

  Scenario: Calculate pay for 1 night of work
  Given I babysit from 17 to 28
  Then I get paid 108
  
  # 5*12 + 2*8 + 4*16
  # 60 + 16 + 32
  # 76 + 108