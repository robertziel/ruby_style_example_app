require 'rails_helper'

describe StartEndDurationService do
  fields_names = %i[start_date end_date duration]

  let(:attributes) do
    group_event_attributes = attributes_for :group_event, :filled
    group_event_attributes.slice(*fields_names)
  end

  let(:stringified_attributes) do
    hash = {}
    attributes.each { |key, value| hash[key] = value.to_s }
    hash
  end

  let(:service_params) { stringified_attributes }

  describe '#call' do
    subject do
      described_class.call(service_params)
    end

    context 'when none attribute is passed' do
      let(:service_params) { {} }

      it 'returns empty hash' do
        expect(subject).to be_empty
      end
    end

    context 'when all attributes are passed' do
      it 'returns empty hash' do
        expect(subject).to be_empty
      end
    end

    fields_names.each do |field_name|
      context "when only #{field_name} is passed" do
        before do
          nullified_fields = (fields_names - [field_name])
          nullified_fields.each do |nullified_field|
            service_params[nullified_field] = nil
          end
        end

        it 'returns empty hash' do
          expect(subject).to be_empty
        end
      end
    end

    context 'when two parameters are passed' do
      fields_combinations = fields_names.combination(2).to_a

      fields_combinations.each do |combination|
        nullified_field = (fields_names - combination).first

        context "when #{combination[0]} and #{combination[1]} is set" do
          let!(:expected_nullified_field_value) { attributes[nullified_field] }

          before do
            service_params[nullified_field] = nil
          end

          it "sets value for #{nullified_field}" do
            nullified_field_value = subject[nullified_field]
            expect(nullified_field_value).to eq expected_nullified_field_value
          end
        end
      end
    end
  end
end
