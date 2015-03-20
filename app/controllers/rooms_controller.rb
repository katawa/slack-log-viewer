class RoomsController < ApplicationController
  def show
    @room = "##{params[:room]}"

    @logs = LogsDecorator.new(Log.where(room: params[:room]).skipped_by_page(params[:page]).order_by(id: 'desc'))
  end
end
