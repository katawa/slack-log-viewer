module Logs
  class Query
    def self.types
      [:text, :user, :room, :date]
    end

    # @param [String] str
    def initialize(str)
      @str = str
    end

    # @return [Array<String>]
    def texts
      parse.select { |q| q.first == :text }.map { |q| /.*#{Regexp.escape(q.last)}.*/i }
    end

    # @return [String, nil]
    def user
      parse_by_type(:user)
    end

    # @return [String, nil]
    def room
      parse_by_type(:room)
    end

    # @return [Time, nil]
    def date
      Time.parse(parse_by_type(:date))
    rescue
      nil
    end

    private

    # @return [Array<Array<Symbol, String>>]
    def parse
      @str.split(/\p{White_Space}+/).map do |q|
        type = to_type(q)
        value = q.split("#{type}:").last
        [type, value]
      end
    end

    # @param [String] str
    # @return [Symbol]
    def to_type(str)
      Query.types.find { |type| str.start_with?("#{type}:") } || :text
    end

    # @param [Symbol] type
    # @return [String]
    def parse_by_type(type)
      parse.find { |q| q.first == type }.andand.last
    end
  end
end
