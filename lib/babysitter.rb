BEDTIME = 22
MIDNIGHT = 24
STAND_RATE = 12
MID_RATE = 8
END_RATE = 16

class BabySit
  attr_reader :hours, :ratepay
  def initialize start, endtime
    @start, @endtime = start, endtime
    @hours = CalculateHours.new(start, endtime)
    @ratepay = RatePay.new(@hours)
  end

  def valid_schedule?
    if @start < 17 || @endtime > 28
      false
    else
      true
    end
  end

  def round_hours
    hours.round_hours
  end

  def calculate_pay
    ratepay.standard_rate + ratepay.mid_rate + ratepay.overnight_rate
  end
end

class RatePay
  def initialize hours
    @hours = hours
  end

  def standard_rate
    STAND_RATE * @hours.early_hours
  end

  def mid_rate
    MID_RATE * @hours.mid_hours
  end

  def overnight_rate
    END_RATE * @hours.overnight_hours
  end
end

class CalculateHours
  attr_reader :start, :endtime
  def initialize start, endtime
    @start, @endtime = start, endtime
  end

  def round_hours
    @start = @start.round
    @endtime = @endtime.round
  end

  def early_hours
    BEDTIME - start
  end

  def mid_hours
    MIDNIGHT - BEDTIME
  end

  def overnight_hours
    endtime - MIDNIGHT
  end
end
