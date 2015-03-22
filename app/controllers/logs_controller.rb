class LogsController < ApplicationController
  def index
    @channels = Log.distinct(:room).sort
  end

  def search
    redirect_to :root if params[:q] == ''

    queries = str_to_queries(params[:q])
    query_texts = queries.select{ |q| q[:type] == 'text' }.map { |q| q[:value] }
    query_user  = queries.select{ |q| q[:type] == 'user' }.first.andand[:value]

    result = Log.search_texts(query_texts).search_user(query_user)
    @number = result.count
    @logs = result.skipped_by_page(params[:page]).decorate
  end

  private

  def str_to_queries(str)
    str.split(/\p{White_Space}+/).map { |q| query(q) }
  end

  def query(str)
    if str.include?(':')
      type, value = str.split(':')
    else
      type = 'text'
      value = str
    end
    {
        type: type,
        value: case type
               when 'user' then
                 value
               else
                 /.*#{Regexp.escape(value)}.*/i
               end
    }
  end
end
