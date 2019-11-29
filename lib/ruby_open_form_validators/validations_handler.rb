# frozen_string_literal: true

require 'ruby_open_form_validators/parser'
require 'ruby_open_form_validators/constants'
require 'active_support/core_ext/date_time/calculations'

module RubyOpenFormValidators
  module ValidationsHandler
    extend self

    def min_value(value, validator)
      handler do
        expected_value = Parser.remove_non_digits(validator)
        valid = Parser.to_number!(value) >= Parser.to_number!(expected_value)
        create_response(valid, "Value must be greater than #{expected_value}")
      end
    end

    def max_value(value, validator)
      handler do
        expected_value = Parser.remove_non_digits(validator)
        valid = Parser.to_number!(value) <= Parser.to_number!(expected_value)
        create_response(valid, "Value must be less than #{expected_value}")
      end
    end

    def min_length(value, validator)
      handler do
        expected_length = Parser.remove_non_digits(validator)
        valid = value.to_s.length >= Parser.to_number!(expected_length)
        create_response(valid, "Length must be longer than #{expected_length} characters")
      end
    end

    def max_length(value, validator)
      handler do
        expected_length = Parser.remove_non_digits(validator)
        valid = value.length <= Parser.to_number!(expected_length)
        create_response(valid, "Length must be shorter than #{expected_length} characters")
      end
    end

    def min_date(value, validator)
      handler do
        expected_value = Parser.remove_non_digits(validator)
        valid = Parser.to_date!(value) >= Parser.to_date!(expected_value)
        create_response(valid, "Date must be after #{expected_value}")
      end
    end

    def max_date(value, validator)
      handler do
        expected_value = Parser.remove_non_digits(validator)
        valid = Parser.to_date!(value) <= Parser.to_date!(expected_value)
        create_response(valid, "Date must be before #{expected_value}")
      end
    end

    def earliest_today(value, _)
      handler do
        today = DateTime.now.beginning_of_day.strftime(Constants::DATE_FORMAT)
        valid = Parser.to_date!(value) >= Parser.to_date!(today)
        create_response(valid, "Date must be after today's date")
      end
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

    def handler
      yield
    rescue StandardError => e
      create_response(false, e.message)
    end
  end
end
