# frozen_string_literal: true

module Orchestration
  module Services
    module ConfigurationBase
      attr_reader :settings

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def service_name=(val)
          @service_name = val
        end

        def service_name
          return @service_name unless @service_name.nil?

          raise ArgumentError,
                "Must call `self.name=` on #{self.class.service_name}"
        end
      end

      def host
        'localhost'
      end

      def local_port
        name = self.class.service_name
        key = name == 'application' ? 'nginx-proxy' : name

        @env.docker_compose_config
            .fetch('services')
            .fetch(key)
            .fetch('ports')
            .first
            .partition(':')
            .first
            .to_i
      end
    end
  end
end
