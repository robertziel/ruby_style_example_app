class StartEndDurationService < ApplicationService
  attr_accessor :start_date, :end_date, :duration

  def initialize(params)
    self.start_date = params[:start_date]
    self.end_date = params[:end_date]
    self.duration = params[:duration]
  end

  def call
    return {} unless two_params_has_value?

    set_start_end_duration
    {
      start_date: start_date,
      end_date: end_date,
      duration: duration
    }
  end

  private

  def set_start_end_duration
    if start_date && end_date
      set_duration
    elsif start_date && duration
      set_end_date
    elsif end_date && duration
      set_start_date
    end
  end

  def set_duration
    self.duration = (end_date - start_date).to_i
  end

  def set_end_date
    self.end_date = start_date + duration.days
  end

  def set_start_date
    self.start_date = end_date - duration.days
  end

  def two_params_has_value?
    [start_date, end_date, duration].compact.length == 2
  end
end
