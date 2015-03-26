module SlackLogViewer
  module Importer
    module Model
      class Log
        def initialize(log, user, channel, team, processor, context)
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
              'text'    => Sanitize.clean(processor.call(log['text'], context)[:output].to_s),
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
          def load(log_file, users, channels)
            channel = channels.find { |channel| channel.name == channel_name(log_file) }

            logs = JSON.load(open(log_file))
            logs.select { |hash| hash['subtype'].nil? }
                .select { |hash| hash['user'] != 'USLACKBOT' }
                .map do |hash|
              user = users.find { |user| user.id == hash['user'] }
              Log.new(hash, user, channel, ENV['team_id'], processor, context(users, channels))
            end
          end

          private

          def channel_name(log_file)
            log_file.split('/')[-2]
          end

          def processor
            @processor ||= SlackMessageMarkdown::Processor.new
          end

          def context(users, channels)
            @context ||= {
                on_get_user: -> (uid) {
                  user = users.find { |user| user.id == uid }
                  user ? {name: user.name} : nil
                },
                on_get_channel: -> (uid) {
                  channel = channels.find { |channel| channel.id == uid }
                  channel ? {name: channel.name} : nil
                }
            }
          end
        end
      end
    end
  end
end
