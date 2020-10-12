class GroupEvent < ApplicationRecord
  include GroupEventStateConcerns

  validate :validate_end_after_start

  with_options if: :published? do
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :duration, presence: true

    validates :name, presence: true
    validates :description, presence: true
    validates :location, presence: true
  end

  private

  # Validations

  def validate_end_after_start
    return if end_date.blank? || start_date.blank?
    return if end_date > start_date

    errors.add(:end_date, :must_be_after_start_date)
  end
end
