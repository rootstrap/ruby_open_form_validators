# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'

RSpec.describe RubyOpenFormValidators do
  it 'has a version number' do
    expect(RubyOpenFormValidators::VERSION).not_to be nil
  end

  subject(:validate) do
    result = RubyOpenFormValidators.validate(test_value, test_validator)
    result[:valid]
  end

  subject(:validate_response) do
    RubyOpenFormValidators.validate(test_value, test_validator)
  end

  let(:sample_string) { 'Lorem Ipsum' }

  describe 'min_value' do
    context 'when value is an integer' do
      let(:test_value) { '10' }

      context 'when is valid' do
        let(:test_validator) { 'minValue5' }

        it 'returns true when value > min_value' do
          expect(validate).to be_truthy
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'minValue15' }

        it 'returns false when value < min_value' do
          expect(validate).to be_falsy
        end
      end
    end

    context 'when value is a float' do
      let(:test_value) { '10.5' }

      context 'when is valid' do
        let(:test_validator) { 'minValue5.9' }

        it 'returns true when value > min_value' do
          expect(validate).to be_truthy
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'minValue10.6' }

        it 'returns false when value < min_value' do
          expect(validate).to be_falsy
        end
      end
    end

    context 'when value is not a number' do
      let(:test_value) { sample_string }
      let(:test_validator) { 'minValue5.9' }

      it 'returns false' do
        expect(validate_response).to include(valid: false, messages: ['invalid numeric value'])
      end
    end
  end

  describe 'max_value' do
    context 'when value is an integer' do
      let(:test_value) { '10' }

      context 'when is valid' do
        let(:test_validator) { 'maxValue15' }

        it 'returns true when value < max_value' do
          expect(validate).to be_truthy
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'maxValue5' }

        it 'returns false when value > max_value' do
          expect(validate).to be_falsy
        end
      end
    end

    context 'when value is a float' do
      let(:test_value) { '10.5' }

      context 'when is valid' do
        let(:test_validator) { 'maxValue10.9' }

        it 'returns true when value < max_value' do
          expect(validate).to be_truthy
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'maxValue1.3' }

        it 'returns false when value > max_value' do
          expect(validate).to be_falsy
        end
      end
    end

    context 'when value is not a number' do
      let(:test_value) { sample_string }
      let(:test_validator) { 'maxValue10' }

      it 'returns false' do
        expect(validate_response).to include(valid: false, messages: ['invalid numeric value'])
      end
    end
  end

  describe 'min_length' do
    let(:test_value) { sample_string }

    context 'when is valid' do
      let(:test_validator) { 'minLength5' }

      it 'returns true for text length > min_length' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minLength15' }

      it 'returns false for text length < min_length' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'max_length' do
    let(:test_value) { sample_string }

    context 'when is valid' do
      let(:test_validator) { 'maxLength15' }

      it 'returns true for text length < max_length' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'maxLength5' }

      it 'returns false for text length > max_length' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'min_date' do
    context 'when is valid' do
      let(:test_value) { '20190810' }
      let(:test_validator) { 'minDate20190805' }

      it 'returns true for date > min_date' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      context 'with valid date format' do
        let(:test_value) { '20190810' }
        let(:test_validator) { 'minDate20190815' }

        it 'returns false for date < min_date' do
          expect(validate).to be_falsy
        end
      end

      context 'with invalid date format' do
        let(:test_value) { sample_string }
        let(:test_validator) { 'minDate20190815' }

        it 'returns false' do
          expect(validate_response).to include(valid: false, messages: ['invalid date'])
        end
      end
    end
  end

  describe 'max_date' do
    context 'when is valid' do
      let(:test_value) { '20190810' }
      let(:test_validator) { 'maxDate20190815' }

      it 'returns true for date < max_date' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      context 'with valid date format' do
        let(:test_value) { '20190810' }
        let(:test_validator) { 'maxDate20190805' }

        it 'returns false for date > max_date' do
          expect(validate).to be_falsy
        end
      end

      context 'with invalid date format' do
        let(:test_value) { sample_string }
        let(:test_validator) { 'minDate20190815' }

        it 'returns false' do
          expect(validate_response).to include(valid: false, messages: ['invalid date'])
        end
      end
    end
  end

  describe 'earliest_today' do
    let(:test_validator) { 'earliestToday' }

    context 'when is valid' do
      context 'today' do
        let(:test_value) { to_date_format(DateTime.now) }

        it 'returns true for date == today' do
          expect(validate).to be_truthy
        end
      end

      context 'next_week' do
        let(:test_value) { to_date_format(1.week.from_now) }

        it 'returns true for date > today' do
          expect(validate).to be_truthy
        end
      end
    end

    context 'when is invalid' do
      context 'with valid date format' do
        let(:test_value) { to_date_format(2.days.ago) }

        it 'returns false for date < today' do
          expect(validate).to be_falsy
        end
      end

      context 'with invalid date format' do
        let(:test_value) { sample_string }

        it 'returns false' do
          expect(validate_response).to include(valid: false, messages: ['invalid date'])
        end
      end
    end
  end

  describe 'email' do
    let(:test_validator) { 'email' }

    context 'when is valid' do
      context 'simple format' do
        let(:test_value) { 'example123@example.com' }

        it 'returns true for correct email format' do
          expect(validate).to be_truthy
        end
      end

      context 'having underscore' do
        let(:test_value) { 'example_123@example.com' }

        it 'returns true for correct email format' do
          expect(validate).to be_truthy
        end
      end

      context 'having special characters' do
        let(:test_value) { 'example_12.3!@example.com' }

        it 'returns true for correct email format' do
          expect(validate).to be_truthy
        end
      end
    end

    context 'when is invalid' do
      context 'without @' do
        let(:test_value) { 'example.com' }

        it 'returns false for email format is incorrect' do
          expect(validate).to be_falsy
        end
      end

      context 'starts with special character' do
        let(:test_value) { '!example@example.com' }

        it 'returns false for email format is incorrect' do
          expect(validate).to be_falsy
        end
      end
    end
  end

  describe 'min_value and max_value' do
    let(:test_value) { '10' }

    context 'when is valid' do
      let(:test_validator) { 'minValue5,maxValue15' }

      it 'returns true for min_value < value < max_value' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minValue15,maxValue25' }

      it 'returns false for value < min_value' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'min_length and max_length' do
    let(:test_value) { sample_string }

    context 'when is valid' do
      let(:test_validator) { 'minLength5,maxLength15' }

      it 'returns true for min_length < length < max_length' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minLength15,maxLength25' }

      it 'returns false for length < min_length' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'min_date and max_date' do
    let(:test_value) { '20190809' }

    context 'when is valid' do
      let(:test_validator) { 'minDate20190808,maxDate20190810' }

      it 'returns true for min_date < date < max_date' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minDate20190815,maxDate20190820' }

      it 'returns true for date < min_date' do
        expect(validate).to be_falsy
      end
    end
  end
end
