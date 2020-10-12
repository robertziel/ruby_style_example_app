class GroupEvent < ApplicationRecord
  include GroupEventStateConcerns

  with_options if: :published? do
    validates :start, presence: true
    validates :end, presence: true
    validates :duration, presence: true

    validates :name, presence: true
    validates :description, presence: true
    validates :location, presence: true
  end
end
