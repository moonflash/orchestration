# frozen_string_literal: true

module Orchestration
  module Services
    module Database
      module Adapters
        class Postgresql
          def name
            'postgresql'
          end

          def image
            'library/postgres'
          end

          def credentials
            {
              'username' => 'postgres',
              'password' => 'password',
              'database' => 'postgres'
            }
          end

          def errors
            [PG::ConnectionBad]
          end

          def default_port
            5432
          end

          def environment
            {
              'PGPORT' => DockerCompose::DatabaseService::PORT.to_s,
              'POSTGRES_PASSWORD' => 'password',
              'PGDATA' => data_dir
            }
          end

          def data_dir
            '/var/pgdata'
          end
        end
      end
    end
  end
end
