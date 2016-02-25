BEDTIME = 22
MIDNIGHT = 24
STAND_RATE = 12
MID_RATE = 8
END_RATE = 16

class BabySit
  def initialize start, endtime
    @start, @endtime = start, endtime
    @hours = CalculateHours.new(start, endtime)
  end

  def valid_schedule?
    if @start < 17 || @endtime > 28
      false
    else
      true
    end
  end

  def calculate_pay
    standard_rate_pay + mid_rate_pay + end_rate_pay
  end

  def standard_rate_pay
    STAND_RATE * @hours.early_hours
  end

  def mid_rate_pay
    MID_RATE * @hours.mid_hours
  end

  def end_rate_pay
    END_RATE * @hours.end_hours
  end
end

class CalculateHours
  def initialize start, endtime
    @start, @endtime = start, endtime
  end

  def early_hours
    BEDTIME - @start
  end

  def mid_hours
    MIDNIGHT - BEDTIME
  end

  def end_hours
    @endtime - MIDNIGHT
  end
end