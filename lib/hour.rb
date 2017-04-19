  require "hour/version"

module Hour
  class Hour
    attr_reader :hours, :minutes, :to_seconds, :days, :hours_less_days, :to_s, :to_formatted_s, :to_a, :to_time, :minutes_in_base10, :to_base10

    def initialize(hours, minutes = 0)
      hours, minutes = hours.split(':') if hours.is_a? String
      @minutes = [minimum = 0, minutes.to_i, maximum = 59].sort[1]
      @minutes_in_base10 = @minutes.to_f / 60
      @to_a = [@hours = hours.to_i, @minutes]
      @to_base10 = @hours + @minutes_in_base10
      @to_s = "#{'%02d' % @hours}:#{'%02d' % @minutes}" # Formats single-digits such that 1 will read '01'
      @to_seconds = (@hours * 60 + @minutes) * 60
      @days = @hours / 24 || 0
      @hours_less_days = @hours - 24 * @days
      @to_formatted_s = "#{@days} day#{'s' unless @days == 1}, " +
                        "#{@hours_less_days} hour#{'s' unless @hours_less_days == 1}, " +
                        "#{@minutes} minute#{'s' unless @minutes == 1}"
      @to_time = Time.new(
        0,                   #year
        1,                   #month
        1 + @days,        #day
        @hours_less_days, #hour
        @minutes,            #minute
        0,                   #second
        0                    #UTC    #TODO: handle both Time.zone format & deprecated UTC default?
      )
    end

    def on_this_day(day_elect = Time.now)
      day_elect.change(day:  day_elect.day + @days,
                       hour: @hours_less_days,
                       min:  @minutes)
    end

    def self.from_time(time_obj)
      return nil if time_obj == nil
      hour = time_obj.hour + (time_obj.day - 1) * 24 if time_obj.year == 0 # Note that we expect Time input to be year 0, month 1 (minimum values). Incrementing day to a value above 1 means "add 24 * x hours", where x is the number of days above 1, so that a day value of 1 and hour value of 4 will be interpreted as "4 hours", whereas a day value of 2 and an hour value of 4 will be interpreted as "28 hours".
      self.new(hour || time_obj.hour, time_obj.min)
    end

    def self.from_base10(num)
      return nil if num == nil
      hour, minute = num.divmod(1)
      self.new(hour, minute * 60)
    end

    alias_method :to_days, :days                        # DEPRECATION: to_days
    alias_method :to_hours_less_days, :hours_less_days  # DEPRECATION: to_hours_less_days

  end
end
