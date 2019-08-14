require "ruby_open_form_validators/parser"
require "ruby_open_form_validators/constants"
require "active_support/core_ext/date_time/calculations"

module RubyOpenFormValidators
  module ValidationsHandler extend self
    def min_value(value, validator)
      expected_value = Parser.remove_non_digits(validator)
      valid = Parser.to_number(value) >= Parser.to_number(expected_value)
      create_response(valid, "Value must be greater than #{expected_value}")
    end

    def max_value(value, validator)
      expected_value = Parser.remove_non_digits(validator)
      valid = Parser.to_number(value) <= Parser.to_number(expected_value)
      create_response(valid, "Value must be less than #{expected_value}")
    end

    def min_length(value, validator)
      expected_length = Parser.remove_non_digits(validator)
      valid = value.length >= Parser.to_number(expected_length)
      create_response(valid, "Length must be longer than #{expected_length} characters")
    end

    def max_length(value, validator)
      expected_length = Parser.remove_non_digits(validator)
      valid = value.length <= Parser.to_number(expected_length)
      create_response(valid, "Length must be shorter than #{expected_length} characters")
    end

    def min_date(value, validator)
      expected_date = Parser.format_date(validator)
      date = Parser.format_date(value)
      valid = date >= expected_date
      create_response(valid, "Date must be after #{Parser.to_date_format(expected_date)}")
    end

    def max_date(value, validator)
      expected_date = Parser.format_date(validator)
      date = Parser.format_date(value)
      valid = date <= expected_date
      create_response(valid, "Date must be before #{Parser.to_date_format(expected_date)}")
    end

    def earliest_today(value, _)
      expected_date = DateTime.now.utc.beginning_of_day
      date = Parser.format_date(value)
      valid = date >= expected_date
      create_response(valid, "Date must be after today's date")
    end

    def email(value, _)
      valid = Constants::EMAIL_REGEX.match?(value)
      create_response(valid, 'Wrong email format')
    end

    def create_response(valid, error_message)
      {
        valid: valid,
        message: valid ? nil : error_message
      }
    end
  end
end
