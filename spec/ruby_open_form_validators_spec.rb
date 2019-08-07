RSpec.describe RubyOpenFormValidators do
  it "has a version number" do
    expect(RubyOpenFormValidators::VERSION).not_to be nil
  end

  context "min_value" do
    it "valid value" do
      expect(RubyOpenFormValidators.validate(value: "20", validator: "minValue10")).to include(valid: true)
    end

    it "invalid value" do
      expected_hash = {
        valid: false,
        message: "20 should be greater than 30"
      }
      expect(RubyOpenFormValidators.validate(value: "20", validator: "minValue30")).to include(expected_hash)
    end
  end

  context "max_value" do
    it "valid value" do
      expect(RubyOpenFormValidators.validate(value: "50", validator: "maxValue100")).to include(valid: true)
    end

    it "invalid value" do
      expected_hash = {
        valid: false,
        message: "70 should be less than 50"
      }
      expect(RubyOpenFormValidators.validate(value: "70", validator: "maxValue50")).to include(expected_hash)
    end
  end

  context "min_length" do
    it "valid length" do
      expect(RubyOpenFormValidators.validate(value: "Lorem ipsum", validator: "minLength8")).to include(valid: true)
    end

    it "invalid length" do
      value = 20
      expected_hash = {
        valid: false,
        message: "Should be longer than #{value} characters"
      }
      expect(RubyOpenFormValidators.validate(value: "Lorem ipsum", validator: "minLength#{value}")).to include(expected_hash)
    end
  end

  context "max_length" do
    it "valid length" do
      expect(RubyOpenFormValidators.validate(value: "Lorem ipsum", validator: "maxLength20")).to include(valid: true)
    end

    it "invalid length" do
      value = 5
      expected_hash = {
        valid: false,
        message: "Should be shorter than #{value} characters"
      }
      expect(RubyOpenFormValidators.validate(value: "Lorem ipsum", validator: "maxLength#{value}")).to include(expected_hash)
    end
  end

  context "min_date" do
    it "valid date: same" do
      expect(RubyOpenFormValidators.validate(value: "20190807", validator: "minDate20190807")).to include(valid: true)
    end

    it "valid date: after" do
      expect(RubyOpenFormValidators.validate(value: "20190915", validator: "minDate20190807")).to include(valid: true)
    end

    it "invalid date" do
      date = "20190808"
      expected_hash = {
        valid: false,
        message: "Date should be after #{date}"
      }
      expect(RubyOpenFormValidators.validate(value: "20190607", validator: "minDate#{date}")).to include(expected_hash)
    end
  end

  context "max_date" do
    it "valid date: same" do
      expect(RubyOpenFormValidators.validate(value: "20190807", validator: "maxDate20190807")).to include(valid: true)
    end

    it "valid date: before" do
      expect(RubyOpenFormValidators.validate(value: "20190615", validator: "maxDate20190807")).to include(valid: true)
    end

    it "invalid date" do
      date = "20190808"
      expected_hash = {
        valid: false,
        message: "Date should be before #{date}"
      }
      expect(RubyOpenFormValidators.validate(value: "20191107", validator: "maxDate#{date}")).to include(expected_hash)
    end
  end

  context "earliest_today" do
    it "valid date: same" do
      date = RubyOpenFormValidators::Parser.to_date_format(DateTime.now)
      expect(RubyOpenFormValidators.validate(value: date, validator: "earliestToday")).to include(valid: true)
    end

    it "valid date: after" do
      date = RubyOpenFormValidators::Parser.to_date_format(1.week.from_now)
      expect(RubyOpenFormValidators.validate(value: date, validator: "earliestToday")).to include(valid: true)
    end

    it "invalid value" do
      date = RubyOpenFormValidators::Parser.to_date_format(2.days.ago)
      expected_hash = {
        valid: false,
        message: "Date should be after today's date"
      }
      expect(RubyOpenFormValidators.validate(value: date, validator: "earliestToday")).to include(expected_hash)
    end
  end

  context "email" do
    it "valid email" do
      expect(RubyOpenFormValidators.validate(value: "example@example.com", validator: "email")).to include(valid: true)
    end

    it "invalid email" do
      expected_hash = {
        valid: false,
        message: "Wrong email format"
      }
      expect(RubyOpenFormValidators.validate(value: "myemail", validator: "email")).to include(expected_hash)
    end
  end
end
