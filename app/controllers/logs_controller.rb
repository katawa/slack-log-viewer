class LogsController < ApplicationController
  def index
  end

  def search
    redirect_to :root && return if params[:q] == ''

    result = Log.search(Logs::Query.new(params[:q]))
    @number = result.count
    @logs = result.skipped_by_page(params[:page]).decorate
  end
end
