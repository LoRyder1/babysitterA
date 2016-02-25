BEDTIME = 22

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

  def to_bedtime
    BEDTIME - @start
  end


end