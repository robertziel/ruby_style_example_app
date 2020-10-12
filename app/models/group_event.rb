class GroupEvent < ApplicationRecord
  DRAFT = 'draft'.freeze
  PUBLISHED = 'published'.freeze
  STATE_TYPES = [DRAFT, PUBLISHED].freeze

  validates :state, inclusion: { in: STATE_TYPES }
end
