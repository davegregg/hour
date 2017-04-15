require "hour/version"

class Hour
  attr_reader :hours, :minutes, :to_seconds, :to_days, :to_hours_less_days, :to_s, :to_formatted_s, :to_a, :to_time

  def initialize(hours, minutes = 0)
    hours, minutes = hours.split(':').map(&:to_i) if hours.is_a? String
    minutes = [1, minutes, 59].sort[1] #clamp: constrains the assignment to the middle value
    @to_s = "#{'%02d' % hours}:#{'%02d' % minutes}"
    @to_a = [@hours = hours, @minutes = minutes]
    @to_seconds = ((hours * 60) + minutes) * 60
    @to_days = hours / 24
    @to_hours_less_days = hours - 24 * @to_days
    @to_formatted_s = "#{@to_days} day#{'s' unless @to_days == 1}, " +
                      "#{@to_hours_less_days} hour#{'s' unless @to_hours_less_days == 1}, " +
                      "#{minutes} minute#{'s' unless minutes == 1}"
    @to_time = Time.new(
      0,                   #year
      1,                   #month
      1 + @to_days,        #day
      @to_hours_less_days, #hour
      minutes,             #minute
      0,                   #second
      0                    #UTC    #TODO: gracefully handle both the new Time.zone format and the deprecated UTC
    )
  end

  def self.from_time(time_obj)
    Hour.new(time_obj.hour, time_obj.min)
  end

end
