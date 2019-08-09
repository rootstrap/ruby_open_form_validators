require "ruby_open_form_validators/version"
require "ruby_open_form_validators/validations_handler"
require "ruby_open_form_validators/parser"
require "active_support/core_ext/string/inflections"

module RubyOpenFormValidators
  def self.validate(value, validator)
    validator_key = Parser.remove_digits(validator).underscore

    if ValidationsHandler.method_defined?(validator_key)
      ValidationsHandler.send(validator_key, value, validator)
    else
      { valid: true, messages: [] }
    end
  end
end
