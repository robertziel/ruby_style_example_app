class GroupEvent < ApplicationRecord
  DRAFT = 'draft'.freeze
  PUBLISHED = 'published'.freeze
  STATE_TYPES = [DRAFT, PUBLISHED].freeze

  validates :state, inclusion: { in: STATE_TYPES }

  with_options if: :published? do
    validates :start, presence: true
    validates :end, presence: true
    validates :duration, presence: true

    validates :name, presence: true
    validates :description, presence: true
    validates :location, presence: true
  end

  # State methods

  def published?
    state == PUBLISHED
  end
end
