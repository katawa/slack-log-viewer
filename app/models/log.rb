class Log
  include Mongoid::Document

  field :done,        type: Boolean
  field :rawMessage,  type: Hash
  field :rawText,     type: String
  field :room,        type: String
  field :text,        type: String
  field :user,        type: Hash
  alias_attribute :raw_message, :rawMessage
  alias_attribute :raw_text,    :rawText

  paginates_per 30

  def datetime
    Time.at(raw_message[:ts].to_i)
  end

  default_scope -> { order_by(id: 'desc') }

  scope :select_room,     ->(room)  { where(room: room) unless room.blank? }
  scope :select_user,     ->(user)  { where('user.name' => user) unless user.blank? }
  scope :search_texts,    ->(texts) { all_in(text: texts) unless texts.empty? }
  scope :skipped_by_page, ->(page)  { skip(default_per_page * (page.to_i - 1)).limit(default_per_page) }

  # @param [Logs::Query] query
  # @return [Array<Log>]
  def self.search(query)
    search_texts(query.texts).select_user(query.user).select_room(query.room)
  end
end
