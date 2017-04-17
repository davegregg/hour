require "hour/version"

module Hour
  class Hour
    attr_reader :hours, :minutes, :to_seconds, :to_days, :to_hours_less_days, :to_s, :to_formatted_s, :to_a, :to_time

    def initialize(hours, minutes = 0)
      hours, minutes = hours.split(':') if hours.is_a? String
      @minutes = [0, minutes.to_i, 59].sort[1]          # Constrains assignment to the middle value, w/o the #Clamp method
      @to_a = [@hours = hours.to_i, @minutes]
      @to_s = "#{'%02d' % @hours}:#{'%02d' % @minutes}" # Formats single-digits such that '1' will be '01'
      @to_seconds = (@hours * 60 + @minutes) * 60
      @to_days = @hours / 24 || 0
      @to_hours_less_days = @hours - 24 * @to_days
      @to_formatted_s = "#{@to_days} day#{'s' unless @to_days == 1}, " +
                        "#{@to_hours_less_days} hour#{'s' unless @to_hours_less_days == 1}, " +
                        "#{@minutes} minute#{'s' unless @minutes == 1}"
      @to_time = Time.new(
        0,                   #year
        1,                   #month
        1 + @to_days,        #day
        @to_hours_less_days, #hour
        @minutes,            #minute
        0,                   #second
        0                    #UTC    #TODO: gracefully handle both the new Time.zone format and the deprecated UTC
      )
    end

    def self.from_time(time_obj)
      hour = time_obj.hour + (time_obj.day - 1) * 24 if time_obj.year == 0 # Note that we expect Time input to be year 0 and day to take 1 as 24 hours, so that a day value of 2 and an hour value of 4 will be interpreted as "28 hours".
      self.new(hour || time_obj.hour, time_obj.min)
    end

  end
end
