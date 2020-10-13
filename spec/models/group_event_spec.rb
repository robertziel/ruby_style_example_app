require 'rails_helper'

describe GroupEvent, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:state).in_array(described_class::STATE_TYPES) }

    context 'when state is draft' do
      subject { build :group_event, :draft, :filled }

      it { should allow_value(nil).for(:end_date) }
      it { should allow_value(nil).for(:start_date) }
      it { should allow_value(nil).for(:duration) }

      it { should allow_value(nil).for(:name) }
      it { should allow_value(nil).for(:description) }
      it { should allow_value(nil).for(:location) }
    end

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
      let(:group_event) { build :group_event, :draft, :filled }

      subject { group_event }

      it { should allow_value(nil).for(:start_date) }
      it { should allow_value(nil).for(:end_date) }

      context 'when end_date is before or the same as start_date' do
        let(:end_date) { group_event.start_date }

        it { should_not allow_value(end_date).for(:end_date) }
      end

      context 'when end_date is after start_date' do
        let(:end_date) { group_event.start_date + 1.day }

        it { should allow_value(end_date).for(:end_date) }
      end
    end

    describe '#validate_duration_is_a_whole_number' do
      subject { build :group_event, :draft, :filled }

      it { should allow_value(nil).for(:duration) }

      it { should allow_value(described_class::DURATION_FACTOR).for(:duration) }
      it { should_not allow_value(described_class::DURATION_FACTOR + 1).for(:duration) }
    end
  end
end
