class ReorderStopsController < ApplicationController

  def update
    stop = Stop.find(params[:id])

    if user.can_reorder_stops?(stop.itinerary_id)
      case params[:type]
      when "down"
        stop.move_lower
      when "up"
        stop.move_higher
      when "top"
        stop.move_to_top
      when "bottom"
        stop.move_to_bottom
      end
    end

    redirect_to itinerary_path(stop.itinerary)
  end

end
