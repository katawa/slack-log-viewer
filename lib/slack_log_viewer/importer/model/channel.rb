module SlackLogViewer
  module Importer
    module Model
      class Channel
        attr_accessor :id, :name

        # @param [Hash] channel
        def initialize(channel)
          self.id = channel['id']
          self.name = channel['name']
        end

        def to_hash
          {
            id: id,
            name: name
          }
        end

        class << self
          # @param [String] file
          # @return [Array<Channel>]
          def load(file)
            JSON.load(open(file)).map { |hash| Channel.new(hash) }
          end
        end
      end
    end
  end
end
