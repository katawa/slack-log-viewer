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
      parse.select{ |q| q.first == :text }.map { |q| /.*#{Regexp.escape(q.last)}.*/i }
    end

    # @return [String, nil]
    def user
      parse.select{ |q| q.first == :user }.first.andand.last
    end

    # @return [String, nil]
    def room
      parse.select{ |q| q.first == :room }.first.andand.last
    end

    # @return [Time, nil]
    def date
      Time.parse(parse.select{ |q| q.first == :date }.first.andand.last)
    rescue
      nil
    end

    private

    # @return [Array<Array<Symbol, String>>]
    def parse
      @str.split(/\p{White_Space}+/).map do |q|
        type = to_type(q)
        value = q.split("#{type.to_s}:").last
        [type, value]
      end
    end

    # @param [String] str
    # @return [Symbol]
    def to_type(str)
      Query.types.select { |type| str.start_with?("#{type.to_s}:") }.first || :text
    end
  end
end
