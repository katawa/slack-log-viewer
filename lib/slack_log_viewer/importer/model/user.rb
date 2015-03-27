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

        def to_hash
          {
            id: id,
            name: name,
            real_name: real_name,
            mail: mail
          }
        end

        class << self
          # @param [String] file
          # @return [Array<User>]
          def load(file)
            JSON.load(open(file)).map { |hash| User.new(hash) }
          end
        end
      end
    end
  end
end
