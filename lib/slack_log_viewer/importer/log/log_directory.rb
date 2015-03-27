module SlackLogViewer
  module Importer
    module Log
      class LogDirectory
        # @param [String] path
        def initialize(path)
          @path = path
        end

        # @return [LogFile]
        def log_files
          Dir.glob("#{@path}/*/*.json").map { |file_path| LogFile.new(file_path) }
        end

        # @return [String]
        def user_file
          "#{@path}/users.json"
        end

        # @return [String]
        def channel_file
          "#{@path}/channels.json"
        end
      end
    end
  end
end
