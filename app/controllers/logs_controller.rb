class LogsController < ApplicationController
  def index
    @channels = Log.distinct(:room).sort
  end

  def search
    return redirect_to :root if params[:q] == ''
    queries = params.require(:q).split(/\p{White_Space}+/).compact.map {|q|
      /.*#{Regexp.escape(q)}.*/i
    }
    @logs = LogsDecorator.new(Log.all_in(text: queries).skipped_by_page(params[:page]).order_by(id: 'desc'))
  end
end
