# frozen_string_literal: true

require 'ruby_open_form_validators/version'
require 'ruby_open_form_validators/validations_handler'
require 'ruby_open_form_validators/parser'
require 'active_support/core_ext/string/inflections'

module RubyOpenFormValidators
  def self.validate(value, validators)
    empty_accum = { text: value, valid: true, messages: [] }
    validators.split(',').each_with_object(empty_accum) do |validator, accum|
      validator_key = Parser.remove_digits(validator).underscore
      result = if ValidationsHandler.method_defined?(validator_key)
                 ValidationsHandler.public_send(validator_key, value, validator)
               else
                 { valid: true, message: nil }
               end

      accum[:valid] &&= result[:valid]
      message = result[:message]
      accum[:messages] << message unless message.nil?
    end
  end
end
