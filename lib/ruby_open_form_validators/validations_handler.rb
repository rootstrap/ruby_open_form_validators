require "ruby_open_form_validators/parser"
require "ruby_open_form_validators/constants"
require "active_support/core_ext/date_time/calculations"

module RubyOpenFormValidators
  module ValidationsHandler extend self
    def min_value(value, validator)
      expected_value = Parser.remove_non_digits(validator).to_i
      is_valid = value.to_i >= expected_value
      create_response is_valid, "#{value.to_i} should be greater than #{expected_value}"
    end

    def max_value(value, validator)
      expected_value = Parser.remove_non_digits(validator).to_i
      is_valid = value.to_i <= expected_value
      create_response is_valid, "#{value.to_i} should be less than #{expected_value}"
    end

    def min_length(value, validator)
      expected_length = Parser.remove_non_digits(validator).to_i
      is_valid = value.length >= expected_length
      create_response is_valid, "Should be longer than #{expected_length} characters"
    end

    def max_length(value, validator)
      expected_length = Parser.remove_non_digits(validator).to_i
      is_valid = value.length <= expected_length
      create_response is_valid, "Should be shorter than #{expected_length} characters"
    end

    def min_date(value, validator)
      expected_date = Parser.format_date(validator)
      date = Parser.format_date(value)
      is_valid = date >= expected_date
      create_response is_valid, "Date should be after #{Parser.to_date_format(expected_date)}"
    end

    def max_date(value, validator)
      expected_date = Parser.format_date(validator)
      date = Parser.format_date(value)
      is_valid = date <= expected_date
      create_response is_valid, "Date should be before #{Parser.to_date_format(expected_date)}"
    end

    def earliest_today(value, _)
      expected_date = DateTime.now.utc.beginning_of_day
      date = Parser.format_date(value)
      is_valid = date >= expected_date
      create_response is_valid, "Date should be after today's date"
    end

    def email(value, _)
      is_valid = Constants::EMAIL_REGEX.match?(value)
      create_response is_valid, 'Wrong email format'
    end

    def create_response(is_valid, error_message)
      {
        valid: is_valid,
        message: is_valid ? nil : error_message
      }
    end
  end
end
