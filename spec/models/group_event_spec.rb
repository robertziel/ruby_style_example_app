require 'rails_helper'

describe GroupEvent, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:state).in_array(described_class::STATE_TYPES) }

    context 'when state is published' do
      subject { build :group_event, :published }

      it { should validate_presence_of(:start_date) }
      it { should validate_presence_of(:end_date) }
      it { should validate_presence_of(:duration) }

      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:location) }
    end

    describe '#validate_end_after_start' do
      subject { build :group_event, :draft, :filled }

      it { should allow_value(nil).for(:start_date) }
      it { should allow_value(nil).for(:end_date) }

      context 'when start_date nor end_date is empty' do
        context 'when end_date is before start_date' do
          let(:end_date) { subject.start_date }

          it { should_not allow_value(end_date).for(:end_date) }
        end

        context 'when end_date is after start_date' do
          let(:end_date) { subject.start_date + 1.day }

          it { should allow_value(end_date).for(:end_date) }
        end
      end
    end
  end
end
