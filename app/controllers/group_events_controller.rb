class GroupEventsController < ApplicationController
  def create
    @group_event = GroupEvent.new(group_event_params)
    if @group_event.save
      json_response(@group_event, :created)
    else
      json_response(@group_event.errors, :unprocessable_entity)
    end
  end

  def update
    @group_event = GroupEvent.find(params[:id])
    if @group_event.update(group_event_params)
      head :no_content
    else
      json_response(@group_event.errors, :unprocessable_entity)
    end
  end

  private

  def group_event_params
    params.permit(:state, :start_date, :end_date, :duration, :name, :description, :location)
  end
end
