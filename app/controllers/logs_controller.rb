class LogsController < ApplicationController
  def index
    @channels = Log.distinct(:room).sort
  end

  def search
    redirect_to :root if params[:q] == ''

    queries = str_to_queries(params[:q])
    result = Log.search_text(queries)
    @number = result.count
    @logs = result.skipped_by_page(params[:page]).decorate
  end

  private

  def str_to_queries(str)
    str.split(/\p{White_Space}+/).map { |q| query(q) }
  end

  def query(str)
    /.*#{Regexp.escape(str)}.*/i
  end
end
