require "ruby_open_form_validators/constants"

module RubyOpenFormValidators
  module Parser extend self
    def remove_non_digits(string)
      string.tr('^0-9', '') if string.respond_to?(:tr)
    end

    def remove_digits(string)
      string.tr('0-9', '') if string.respond_to?(:tr)
    end

    def format_date(date)
      DateTime.parse(date, Constants::DATE_FORMAT)
    end

    def to_date_format(date)
      date.strftime(Constants::DATE_FORMAT) if date.respond_to?(:strftime)
    end
  end
end
