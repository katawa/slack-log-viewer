class Log
  include Mongoid::Document

  field :done,        type: Boolean
  field :rawMessage,  type: Hash
  field :rawText,     type: String
  field :room,        type: String
  field :text,        type: String
  field :user,        type: Hash
  field :datetime,    type: Time
  alias_attribute :raw_message, :rawMessage
  alias_attribute :raw_text,    :rawText

  paginates_per 30

  default_scope -> { order_by(datetime: 'desc') }

  scope :select_room,     ->(room)  { where(room: room) unless room.blank? }
  scope :select_user,     ->(user)  { where('user.name' => user) unless user.blank? }
  scope :select_date,     ->(date)  { where(datetime: { '$lte' => date.end_of_day , '$gt' => date.beginning_of_day }) unless date.blank? }
  scope :search_texts,    ->(texts) { all_in(text: texts) unless texts.empty? }
  scope :skipped_by_page, ->(page)  { skip(default_per_page * (page.to_i - 1)).limit(default_per_page) }

  Log.where('raw_message.ts' => { '$lte' => Time.now , '$gt' => (Time.now - 7.days) })
  # @param [Logs::Query] query
  # @return [Array<Log>]
  def self.search(query)
    search_texts(query.texts)
        .select_user(query.user)
        .select_room(query.room)
        .select_date(query.date)
  end
end
