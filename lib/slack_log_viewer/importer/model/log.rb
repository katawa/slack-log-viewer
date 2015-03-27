module SlackLogViewer
  module Importer
    module Model
      class Log
        def initialize(log, user, channel, team, context) # rubocop:disable all
          @hash = {
            'done' => false,
            'rawMessage' => {
              'type'    => 'message',
              'user'    => user.id,
              'channel' => channel.id,
              'team'    => team,
              'text'    => log['text'],
              'ts'      => log['ts']
            },
            'rawText' => log['text'],
            'room'    => channel.name,
            'text'    => Sanitize.clean(Log.processor.call(log['text'], context)[:output].to_s),
            'id'      => log['ts'],
            'user' => {
              'email_address' => user.mail,
              'id'            => user.id,
              'name'          => user.name,
              'real_name'     => user.real_name,
              'room'          => channel.name
            },
            'datetime' => Time.at(log['ts'].to_i)
          }
        end

        def to_bson
          @hash.to_bson
        end

        class << self
          # @param [SlackLogViewer::Importer::Log::LogFile] log_file
          # @param [Array<User>] users
          # @param [Array<Channel>] channels
          # @return [Array<Log>]
          def load(log_file, users, channels)
            channel = channels.find { |ch| ch.name == log_file.channel_name }

            log_file.read.map do |log|
              user = users.find { |u| u.id == log['user'] }
              Log.new(log, user, channel, ENV['team_id'], context(users, channels))
            end
          end

          def processor
            @processor ||= SlackMessageMarkdown::Processor.new
          end

          private

          def context(users, channels)
            @context ||= {
              on_get_user: ->(uid) { users.find { |u| u.id == uid }.andand.to_hash },
              on_get_channel: ->(uid) { channels.find { |ch| ch.id == uid }.andand.to_hash }
            }
          end
        end
      end
    end
  end
end
