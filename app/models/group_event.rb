class GroupEvent < ApplicationRecord
  DURATION_FACTOR = 30

  include GroupEventStateConcerns

  validate :validate_end_after_start
  validate :validate_duration_is_a_whole_number

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

  def validate_duration_is_a_whole_number
    return if duration.nil?

    the_rest = duration % DURATION_FACTOR
    return if the_rest.zero?

    errors.add(:duration, :must_be_whole_number)
  end
end
