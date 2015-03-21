class RoomsController < ApplicationController
  def show
    @room = params[:room]
    @logs = Log.select_room(params[:room]).skipped_by_page(params[:page]).decorate
  end
end
