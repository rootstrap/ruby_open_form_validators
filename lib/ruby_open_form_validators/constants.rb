# frozen_string_literal: true

module RubyOpenFormValidators
  module Constants
    EMAIL_REGEX = %r{\A[a-zA-Z0-9][a-zA-Z0-9.!\#$%&'*+/=?^_`{|}~-]*
                  @
                  [a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?
                  (?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z}x.freeze

    DATE_FORMAT = '%Y%m%d'
  end
end
