require "ruby_open_form_validators/constants"

module RubyOpenFormValidators
  module Parser extend self
    def remove_non_digits(string)
      string.gsub(/^[a-zA-Z]+/, '') if string.respond_to?(:gsub)
    end

    def remove_digits(string)
      string.gsub(/\d+(.\d+(e[+-]\d+)?)?/, '') if string.respond_to?(:gsub)
    end

    def to_date!(attribute)
      Date.parse(attribute, Constants::DATE_FORMAT)
    end

    def to_number!(attribute)
      return attribute if attribute.is_a?(Numeric)
      return attribute.to_f if attribute.is_a?(String) && numeric?(attribute)
      raise "invalid numeric value"
    end

    def numeric?(string_number)
      Float(string_number) != nil rescue false
    end
  end
end
