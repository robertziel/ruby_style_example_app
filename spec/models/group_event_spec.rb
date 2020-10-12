require 'rails_helper'

describe GroupEvent, type: :model do
  describe '#validations' do
    it { should validate_inclusion_of(:state).in_array(described_class::STATE_TYPES) }

    context 'when state is published' do
      subject { build :group_event, :published }

      it { should validate_presence_of(:start) }
      it { should validate_presence_of(:end) }
      it { should validate_presence_of(:duration) }

      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:location) }
    end
  end
end
