module DateHelper
  def to_date_format(date)
    date.strftime(RubyOpenFormValidators::Constants::DATE_FORMAT) if date.respond_to?(:strftime)
  end
end
