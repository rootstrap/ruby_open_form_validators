require "active_support/core_ext/numeric/time"

RSpec.describe RubyOpenFormValidators do
  it 'has a version number' do
    expect(RubyOpenFormValidators::VERSION).not_to be nil
  end

  subject(:validate) do
    result = RubyOpenFormValidators.validate(test_value, test_validator)
    result[:valid]
  end

  describe 'min_value' do
    let(:test_value) { '10' }
    context 'is_valid' do
      let(:test_validator) { 'minValue5' }
      it 'returns true when value > expected value' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minValue10' }
      it 'returns true when value == expected value' do
        expect(validate).to be_truthy
      end
    end

    context 'is_invalid' do
      let(:test_validator) { 'minValue15' }
      it 'returns false when value < expected value' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'max_value' do
    let(:test_value) { '10' }
    context 'is_valid' do
      let(:test_validator) { 'maxValue15' }
      it 'returns true when value < expected value' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'maxValue10' }
      it 'returns true when value == expected value' do
        expect(validate).to be_truthy
      end
    end

    context 'is_invalid' do
      let(:test_validator) { 'maxValue5' }
      it 'returns false when value < expected value' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'min_length' do
    let(:test_value) { 'Lorem ipsum' }
    context 'is_valid' do
      let(:test_validator) { 'minLength5' }
      it 'returns true when text length > expected length' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minLength11' }
      it 'returns true when text length == expected length' do
        expect(validate).to be_truthy
      end
    end

    context 'is_invalid' do
      let(:test_validator) { 'minLength15' }
      it 'returns false when text length < expected length' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'max_length' do
    let(:test_value) { 'Lorem ipsum' }
    context 'is_valid' do
      let(:test_validator) { 'maxLength15' }
      it 'returns true when text length < expected length' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'maxLength11' }
      it 'returns true when text length == expected length' do
        expect(validate).to be_truthy
      end
    end

    context 'is_invalid' do
      let(:test_validator) { 'maxLength5' }
      it 'returns false when text length > expected length' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'min_date' do
    let(:test_value) { '20190810' }
    context 'is_valid' do
      let(:test_validator) { 'minDate20190805' }
      it 'returns true when date > expected date' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minDate20190810' }
      it 'returns true when date == expected date' do
        expect(validate).to be_truthy
      end
    end

    context 'is_invalid' do
      let(:test_validator) { 'minDate20190815' }
      it 'returns false when date < expected date' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'max_date' do
    let(:test_value) { '20190810' }
    context 'is_valid' do
      let(:test_validator) { 'maxDate20190815' }
      it 'returns true when date < expected date' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'maxDate20190810' }
      it 'returns true when date == expected date' do
        expect(validate).to be_truthy
      end
    end

    context 'is_invalid' do
      let(:test_validator) { 'maxDate20190805' }
      it 'returns false when date > expected date' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'earliest_today' do
    context 'is_valid' do
      context 'today' do
        let(:test_value) { RubyOpenFormValidators::Parser.to_date_format(DateTime.now) }
        let(:test_validator) { 'earliestToday' }
        it 'returns true when date == today' do
          expect(validate).to be_truthy
        end
      end

      context 'next_week' do
        let(:test_value) { RubyOpenFormValidators::Parser.to_date_format(1.week.from_now) }
        let(:test_validator) { 'earliestToday' }
        it 'returns true when date > today' do
          expect(validate).to be_truthy
        end
      end
    end

    context 'is_invalid' do
      let(:test_value) { RubyOpenFormValidators::Parser.to_date_format(2.days.ago) }
      let(:test_validator) { 'earliestToday' }
      it 'returns false when date < today' do
        expect(validate).to be_falsy
      end
    end
  end

   describe 'email' do
    context 'is_valid' do
      context 'simple format' do
        let(:test_value) { 'example123@example.com' }
        let(:test_validator) { 'email' }
        it 'returns true when email is correct' do
          expect(validate).to be_truthy
        end
      end

      context 'having underscore' do
        let(:test_value) { 'example_123@example.com' }
        let(:test_validator) { 'email' }
        it 'returns true when email is correct' do
          expect(validate).to be_truthy
        end
      end

      context 'having special characters' do
        let(:test_value) { "example_12.3!@example.com" }
        let(:test_validator) { 'email' }
        it 'returns true when email is correct' do
          expect(validate).to be_truthy
        end
      end
    end

    context 'is_invalid' do
      context 'without @' do
        let(:test_value) { 'example.com' }
        let(:test_validator) { 'email' }
        it 'returns false when email format is incorrect' do
          expect(validate).to be_falsy
        end
      end

      context 'starts with special character' do
        let(:test_value) { '!example@example.com' }
        let(:test_validator) { 'email' }
        it 'returns false when email format is incorrect' do
          expect(validate).to be_falsy
        end
      end
    end
  end
end
