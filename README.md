# RubyOpenFormValidators

Ruby gem for validating OpenForm. It supports several validators such as *minValue*, *maxValue*, *minLength*, *maxLength*, *minDate, *maxDate, *earliestToday, *email*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_open_form_validators'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_open_form_validators

## Usage

Passing validations will return the same result.
```ruby
$ RubyOpenFormValidators.validate("50", "minValue25"):
{ valid: true, message: nil }
```

Failing validations will return different messages according to the used validator.
Examples of every supported validator:
```ruby
$ RubyOpenFormValidators.validate("20", "minValue25")
{ valid: false, message: "20 should be greater than 25" }

$ RubyOpenFormValidators.validate("100", "maxValue80")
{ valid: false, message: "100 should be less than 80" }

$ RubyOpenFormValidators.validate("hello world", "minLength20")
{ valid: false, message: "Should be longer than 20 characters" }

$ RubyOpenFormValidators.validate("hello world", "maxLength8")
{ valid: false, message: "Should be shorter than 8 characters" }

$ RubyOpenFormValidators.validate("20190905", "minDate20190806")
{ valid: false, message: "Date should be after 20190806" }

$ RubyOpenFormValidators.validate("20190907", "maxDate20190806")
{ valid: false, message: "Date should be before 20190806" }

$ RubyOpenFormValidators.validate("20181206", "earliestToday")
{ valid: false, message: "Date should be after today's date" }

$ RubyOpenFormValidators.validate("@example.com", "email")
{ valid: false, message: "Wrong email format" }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby_open_form_validators. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyOpenFormValidators project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rootstrap/ruby_open_form_validators/blob/master/CODE_OF_CONDUCT.md).
