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

        class << self
          def load(log_dir)
            JSON.load(open("#{log_dir}/channels.json")).map { |hash| Channel.new(hash) }
          end
        end
      end
    end
  end
end
