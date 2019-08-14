require "ruby_open_form_validators/constants"

module RubyOpenFormValidators
  module Parser extend self
    def remove_non_digits(string)
      string.gsub(/^[a-zA-Z]+/, '') if string.respond_to?(:gsub)
    end

    def remove_digits(string)
      string.gsub(/\d+(.\d+(e[+-]\d+)?)?/, '') if string.respond_to?(:gsub)
    end

    def format_date(date)
      DateTime.parse(date, Constants::DATE_FORMAT)
    end

    def to_date_format(date)
      date.strftime(Constants::DATE_FORMAT) if date.respond_to?(:strftime)
    end

    def to_number(string_number)
      if numeric?(string_number)
        string_number.to_f == string_number.to_i ? string_number.to_i : string_number.to_f
      else
        string_number
      end
    end

    def numeric?(string_number)
      Float(string_number) != nil rescue false
    end
  end
end
