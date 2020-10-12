module GroupEventStateConcerns
  extend ActiveSupport::Concern

  DRAFT = 'draft'.freeze
  PUBLISHED = 'published'.freeze
  STATE_TYPES = [DRAFT, PUBLISHED].freeze

  included do
    validates :state, inclusion: { in: STATE_TYPES }
  end

  STATE_TYPES.each do |state_type|
    define_method "#{state_type}?" do
      state == state_type
    end
  end
end
