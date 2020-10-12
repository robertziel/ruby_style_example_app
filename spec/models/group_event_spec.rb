require 'rails_helper'

describe GroupEvent, type: :model do
  describe '#validations' do
    it { validate_inclusion_of(:state).in_array(described_class::STATE_TYPES) }
  end
end
