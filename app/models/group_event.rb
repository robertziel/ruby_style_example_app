class GroupEvent < ApplicationRecord
  include GroupEventStateConcerns

  with_options if: :published? do
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :duration, presence: true

    validates :name, presence: true
    validates :description, presence: true
    validates :location, presence: true
  end
end
