module Logs
  class Query
    def self.types
      [:text, :user]
    end

    # @param [String] str
    def initialize(str)
      @str = str
    end

    # @return [Array<String>]
    def texts
      parse.select{ |q| q.first == :text }.map { |q| /.*#{Regexp.escape(q.last)}.*/i }
    end

    # @return [String]
    def user
      parse.select{ |q| q.first == :user }.first.andand.last
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
