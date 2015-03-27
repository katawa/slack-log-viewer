module SlackLogViewer
  module Importer
    class Importer
      class << self
        Model = SlackLogViewer::Importer::Model

        # @param [Log::LogDirectory] log_dir
        def load(log_dir)
          users    = Model::User.load(log_dir.user_file)
          channels = Model::Channel.load(log_dir.channel_file)

          logs = log_dir.log_files.flat_map do |log_file|
            logger.info("read: #{log_file}")
            Model::Log.load(log_file, users, channels)
          end

          logs.map { |log| db_collection.insert(log) }
        end

        private

        def logger
          @logger ||= Logger.new(STDOUT)
        end

        def db_collection
          @collection ||= Mongoid::Sessions.default[:logs]
        end
      end
    end
  end
end
