module ApplicationHelper
  def search?
    request.path_info =~ %r{/logs/search.*}
  end

  def current_room?(room)
    @room == room
  end

  def rooms
    Log.distinct(:room).sort.map
  end
end
