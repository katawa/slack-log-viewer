module SlackLogViewer
  module Importer
    module Log
      class LogFile
        # @param [String] path
        def initialize(path)
          @path = path
        end

        # @return [Array<Hash{String => String}>]
        def read
          logs.select { |hash| LogFile.valid_log(hash) }
        end

        # @return [String]
        def channel_name
          @channe_name ||= @path.split('/')[-2]
        end

        # @return [String]
        def to_s
          @path
        end

        private

        # @return [Array<Hash{String => String}>]
        def logs
          JSON.load(open(@path))
        end

        # @param [Hash{String => String}] log
        # @return [Boolean]
        def self.valid_log(log)
          log['subtype'].nil? && log['user'] != 'USLACKBOT'
        end
      end
    end
  end
end
