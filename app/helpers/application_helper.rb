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

  # assets
  def webpack_entry_tag(entry)
    javascript_include_tag(AssetManifest.webpack_entry_path(entry))
  end
end
