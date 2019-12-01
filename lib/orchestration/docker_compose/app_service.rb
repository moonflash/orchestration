# frozen_string_literal: true

module Orchestration
  module DockerCompose
    class AppService
      def initialize(config, environment)
        @environment = environment
        @config = config
      end

      def definition
        {
          'image' => '${DOCKER_ORGANIZATION}/${DOCKER_REPOSITORY}',
          'environment' => environment,
          'expose' => [8080],
          'volumes' => [
            "#{@config.env.public_volume}:/app/public/:ro"
          ]
        }
      end

      private

      def environment
        {
          'DATABASE_URL' => @config.database_url,
          'RAILS_LOG_TO_STDOUT' => '1',
          'UNICORN_PRELOAD_APP' => '1',
          'UNICORN_TIMEOUT' => '60',
          'UNICORN_WORKER_PROCESSES' => '8',
          'VIRTUAL_PORT' => '8080'
        }.merge(inherited_environment)
      end

      def inherited_environment
        {
          'HOST_UID' => nil,
          'RAILS_ENV' => nil,
          'SECRET_KEY_BASE' => nil,
          'VIRTUAL_HOST' => nil
        }
      end
    end
  end
end
