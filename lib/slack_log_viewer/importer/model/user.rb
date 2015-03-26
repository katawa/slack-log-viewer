module SlackLogViewer
  module Importer
    module Model
      class User
        attr_accessor :id, :name, :real_name, :mail

        # @param [Hash] user
        def initialize(user)
          self.id = user['id']
          self.name = user['name']
          self.real_name = user['real_name']
          self.mail = user['profile']['email']
        end

        class << self
          def load(log_dir)
            JSON.load(open("#{log_dir}/users.json")).map { |hash| User.new(hash) }
          end
        end
      end
    end
  end
end
