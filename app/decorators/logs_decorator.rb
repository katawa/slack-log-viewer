class LogsDecorator < Draper::CollectionDecorator
  def group_by_date
    group_by { |log| log.datetime.strftime('%Y/%m/%d') }
  end

  def group_by_room
    group_by(&:room).sort { |a, b| a.first <=> b.first }
  end

  def to_kaminari
    object.skip(0).limit(0)
  end
end
