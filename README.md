# Hour

A simple class for handling hours and minutes, without the baggage of the Time or DateTime classes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hour'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hour

## Usage

The Hour class accepts an hour-and-minute, like so: `Hour::Hour.new('17:30')` or `Hour::Hour.new('48:00')`; alternatively: `Hour::Hour.new(17,30)` or `Hour::Hour.new(48)`.

You can also convert a Ruby Time object to a Hour object, like so: `Hour::Hour.from_time(Time.now)`.

Valid methods include:

```ruby
interval = Hour.new(28, 30)
interval.hours
  # => 28
interval.minutes
  # => 30
interval.to_a
  # => [28, 30]
interval.to_s
  # => "28:30"
interval.to_seconds
  # => 102600
interval.to_days
  # => 1
interval.to_hours_less_days
  # => 4
interval.to_formatted_s
  # => "1 day, 4 hours, 30 minutes"
interval.to_time
  # => 0000-01-02 04:30:00 +0000
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davegregg/hour. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
