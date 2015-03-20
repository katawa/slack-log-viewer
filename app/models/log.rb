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

  scope :skipped_by_page, ->(page) { skip(default_per_page * (page.to_i - 1)).limit(Log.default_per_page) }
end
