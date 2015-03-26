module SlackLogViewer
  module Importer
    class Importer
      class << self
        def load(log_dir)
          users    = SlackLogViewer::Importer::Model::User.load(log_dir)
          channels = SlackLogViewer::Importer::Model::Channel.load(log_dir)

          logs = log_files(log_dir).flat_map do |log_file|
            logger.info("import #{log_file}")
            SlackLogViewer::Importer::Model::Log.load(log_file, users, channels)
          end

          logs.map { |log| db_collection.insert(log) }
        end

        private

        def logger
          @logger ||= Logger.new(STDOUT)
        end

        def log_files(log_dir)
          Dir.glob("#{log_dir}/*/*.json")
        end

        def db_collection
          @collection ||= Mongoid::Sessions.default[:logs]
        end
      end
    end
  end
end
