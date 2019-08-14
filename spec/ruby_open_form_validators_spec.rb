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
    context 'when value is an integer' do
      let(:test_value) { '10' }

      context 'when is valid' do
        context 'value > min_value' do
          let(:test_validator) { 'minValue5' }

          it { expect(validate).to be_truthy }
        end

        context 'value == min_value' do
          let(:test_validator) { 'minValue10' }

          it { expect(validate).to be_truthy }
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'minValue15' }

        context 'value < min_value' do
          it { expect(validate).to be_falsy }
        end
      end
    end

    context 'when value is a float' do
      let(:test_value) { '10.5' }

      context 'when is valid' do
        context 'value > min_value' do
          let(:test_validator) { 'minValue5.9' }

          it { expect(validate).to be_truthy }
        end

        context 'value == min_value' do
          let(:test_validator) { 'minValue10.5' }

          it { expect(validate).to be_truthy }
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'minValue10.6' }

        context 'value < min_value' do
          it { expect(validate).to be_falsy }
        end
      end
    end
  end

  describe 'max_value' do
    context 'when value is an integer' do
      let(:test_value) { '10' }

      context 'when is valid' do
        context 'value < max_value' do
          let(:test_validator) { 'maxValue15' }

          it { expect(validate).to be_truthy }
        end

        context 'value == max_value' do
          let(:test_validator) { 'maxValue10' }

          it { expect(validate).to be_truthy }
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'maxValue5' }

        context 'value > max_value' do
          it { expect(validate).to be_falsy }
        end
      end
    end

    context 'when value is a float' do
      let(:test_value) { '10.5' }

      context 'when is valid' do
        context 'value < max_value' do
          let(:test_validator) { 'maxValue10.9' }

          it { expect(validate).to be_truthy }
        end

        context 'value == max_value' do
          let(:test_validator) { 'maxValue10.5' }

          it { expect(validate).to be_truthy }
        end
      end

      context 'when is invalid' do
        let(:test_validator) { 'maxValue1.3' }

        context 'value > max_value' do
          it { expect(validate).to be_falsy }
        end
      end
    end
  end

  describe 'min_length' do
    let(:test_value) { 'Lorem ipsum' }

    context 'when is valid' do
      let(:test_validator) { 'minLength5' }

      it 'returns true for text length > min_length' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minLength11' }

      it 'returns true for text length == min_length' do
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
    let(:test_value) { 'Lorem ipsum' }

    context 'when is valid' do
      let(:test_validator) { 'maxLength15' }

      it 'returns true for text length < max_length' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'maxLength11' }

      it 'returns true for text length == max_length' do
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
    let(:test_value) { '20190810' }

    context 'when is valid' do
      let(:test_validator) { 'minDate20190805' }

      it 'returns true for date > min_date' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minDate20190810' }

      it 'returns true for date == min_date' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minDate20190815' }

      it 'returns false for date < min_date' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'max_date' do
    let(:test_value) { '20190810' }

    context 'when is valid' do
      let(:test_validator) { 'maxDate20190815' }

      it 'returns true for date < max_date' do
        expect(validate).to be_truthy


      end

      let(:test_validator) { 'maxDate20190810' }

      it 'returns true for date == max_date' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'maxDate20190805' }

      it 'returns false for date > max_date' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'earliest_today' do
    context 'when is valid' do
      context 'today' do
        let(:test_value) { RubyOpenFormValidators::Parser.to_date_format(DateTime.now) }
        let(:test_validator) { 'earliestToday' }

        it 'returns true for date == today' do
          expect(validate).to be_truthy
        end
      end

      context 'next_week' do
        let(:test_value) { RubyOpenFormValidators::Parser.to_date_format(1.week.from_now) }
        let(:test_validator) { 'earliestToday' }

        it 'returns true for date > today' do
          expect(validate).to be_truthy
        end
      end
    end

    context 'when is invalid' do
      let(:test_value) { RubyOpenFormValidators::Parser.to_date_format(2.days.ago) }
      let(:test_validator) { 'earliestToday' }

      it 'returns false for date < today' do
        expect(validate).to be_falsy
      end
    end
  end

   describe 'email' do
    context 'when is valid' do
      context 'simple format' do
        let(:test_value) { 'example123@example.com' }
        let(:test_validator) { 'email' }

        it 'returns true for correct email format' do
          expect(validate).to be_truthy
        end
      end

      context 'having underscore' do
        let(:test_value) { 'example_123@example.com' }
        let(:test_validator) { 'email' }

        it 'returns true for correct email format' do
          expect(validate).to be_truthy
        end
      end

      context 'having special characters' do
        let(:test_value) { "example_12.3!@example.com" }
        let(:test_validator) { 'email' }

        it 'returns true for correct email format' do
          expect(validate).to be_truthy
        end
      end
    end

    context 'when is invalid' do
      context 'without @' do
        let(:test_value) { 'example.com' }
        let(:test_validator) { 'email' }

        it 'returns false for email format is incorrect' do
          expect(validate).to be_falsy
        end
      end

      context 'starts with special character' do
        let(:test_value) { '!example@example.com' }
        let(:test_validator) { 'email' }

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

      let(:test_validator) { 'minValue10,maxValue15' }

      it 'returns true for min_value == value < max_value' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minValue5,maxValue10' }

      it 'returns true for min_value < value == max_value' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minValue10,maxValue10' }

      it 'returns true for min_value == value == max_value' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minValue15,maxValue25' }

      it 'returns false for value < min_value' do
        expect(validate).to be_falsy
      end

      let(:test_validator) { 'minValue5,maxValue8' }

      it 'returns false for value > max_value' do
        expect(validate).to be_falsy
      end
    end
  end

  describe 'min_length and max_length' do
    let(:test_value) { 'Lorem ipsum' }

    context 'when is valid' do
      let(:test_validator) { 'minLength5,maxLength15' }

      it 'returns true for min_length < length < max_length' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { "minLength11,maxLength15" }

      it 'returns true for min_length == length < max_length' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { "minLength5,maxLength11" }

      it 'returns true for min_length < length == max_length' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { "minLength11,maxLength11" }

      it 'returns true for min_length == length == max_length' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minLength15,maxLength25' }

      it 'returns false for length < min_length' do
        expect(validate).to be_falsy
      end

      let(:test_validator) { 'minLength5,maxLength8' }

      it 'returns false for length > max_length' do
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

      let(:test_validator) { 'minDate20190809,maxDate20190810' }

      it 'returns true for min_date == date < max_date' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minDate20190808,maxDate20190809' }

      it 'returns true for min_date < date == max_date' do
        expect(validate).to be_truthy
      end

      let(:test_validator) { 'minDate20190809,maxDate20190809' }

      it 'returns true for min_date == date == max_date' do
        expect(validate).to be_truthy
      end
    end

    context 'when is invalid' do
      let(:test_validator) { 'minDate20190815,maxDate20190820' }

      it 'returns true for date < min_date' do
        expect(validate).to be_falsy
      end

      let(:test_validator) { 'minDate20190801,maxDate20190806' }

      it 'returns true for date > max_date' do
        expect(validate).to be_falsy
      end
    end
  end
end
