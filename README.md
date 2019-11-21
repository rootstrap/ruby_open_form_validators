[![Build Status](https://travis-ci.org/rootstrap/ruby_open_form_validators.svg?branch=master)](https://travis-ci.org/rootstrap/ruby_open_form_validators)

# RubyOpenFormValidators

Ruby impementation of the Open Form Validators library (https://github.com/rootstrap/open-form-validators). It supports several validators such as *minValue*, *maxValue*, *minLength*, *maxLength*, *minDate, *maxDate, *earliestToday*, *email* and also combinations.

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

It can be used using a single or a combined validator string.

Passing validations will return the same result:
```ruby
$ RubyOpenFormValidators.validate("50", "minValue25")
{ text: "50", valid: true, messages: [] }

$ RubyOpenFormValidators.validate("Lorem ipsum", "minLength5, maxLength15")
{ text: "Lorem ipsum", valid: true, messages: [] }
```

Failing validations will return different messages according to the used validators.
```ruby
# Single validator examples:
$ RubyOpenFormValidators.validate("20", "minValue25")
{ text: "20", valid: false, message: "Value must be greater than 25" }

$ RubyOpenFormValidators.validate("Lorem ipsum", "maxLength5")
{ text: "Lorem ipsum", valid: false, message: "Length must be shorter than 5 characters" }

$ RubyOpenFormValidators.validate("20190905", "minDate20190806")
{ text: "20190905", valid: false, message: "Date must be after 20190806" }

$ RubyOpenFormValidators.validate("20181206", "earliestToday")
{ text: "20181206", valid: false, message: "Date must be after today's date" }

$ RubyOpenFormValidators.validate("@example.com", "email")
{ text: @example., valid: false, message: "Wrong email format" }

# Combined validator examples:
$ RubyOpenFormValidators.validate("20", "minValue25,maxValue30")
{ text: "20", valid: false, message: "Value must be greater than 25" }

$ RubyOpenFormValidators.validate("Lorem ipsum", "minLength2,maxLength5")
{ text: "Lorem ipsum", valid: false, message: "Length must be shorter than 5 characters" }

$ RubyOpenFormValidators.validate("20190905", "minDate20190806,maxDate20190810")
{ text: "20190905", valid: false, message: "Date must be after 20190806" }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Please read our [CONTRIBUTING](https://github.com/rootstrap/ruby_open_form_validators/blob/master/CONTRIBUTING.md) and our [CODE_OF_CONDUCT](https://github.com/rootstrap/ruby_open_form_validators/blob/master/CODE_OF_CONDUCT.md) files for details on our code of conduct, and the process for submitting pull requests to us.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyOpenFormValidators project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rootstrap/ruby_open_form_validators/blob/master/CODE_OF_CONDUCT.md).

## Credits

RubyOpenFormValidators is maintained by [Rootstrap](http://www.rootstrap.com) with the help of our
[contributors](https://github.com/rootstrap/ruby_open_form_validators/contributors).

[<img src="https://s3-us-west-1.amazonaws.com/rootstrap.com/img/rs.png" width="100"/>](http://www.rootstrap.com)
