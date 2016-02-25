BEDTIME = 22
MIDNIGHT = 24

class BabySit
  def initialize start, endtime
    @start, @endtime = start, endtime
  end

  def valid_schedule?
    if @start < 17 || @endtime > 28
      false
    else
      true
    end
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
end