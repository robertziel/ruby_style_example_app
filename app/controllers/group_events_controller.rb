class GroupEventsController < ApplicationController
  before_action :set_group_event, only: %i[show update destroy]

  def index
    @group_events = GroupEvent.all
    json_response(@group_events)
  end

  def create
    @group_event = GroupEvent.new(group_event_params)
    if @group_event.save
      json_response(@group_event, :created)
    else
      json_response(@group_event.errors, :unprocessable_entity)
    end
  end

  def show
    json_response(@group_event)
  end

  def update
    if @group_event.update(group_event_params)
      head :no_content
    else
      json_response(@group_event.errors, :unprocessable_entity)
    end
  end

  def destroy
    @group_event.destroy
    head :no_content
  end

  private

  def group_event_params
    params.permit(:state, :start_date, :end_date, :duration, :name, :description, :location)
  end

  def set_group_event
    @group_event = GroupEvent.find(params[:id])
  end
end
