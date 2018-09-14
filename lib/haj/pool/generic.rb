module HAJ

  module Pool
    # Class to provide a POC for better pooling.
    class Generic

      DEFAULT_HOST     = 'localhost'.freeze
      DEFAULT_PORT     = 6379
      DEFAULT_TIMEOUT  = 2000
      DEFAULT_DATABASE = 0

      def initialize(opts = {})
        config = HAJ::Pool::Config.new(opts)

        host     = opts.fetch(:host) { DEFAULT_HOST }
        port     = opts.fetch(:port) { DEFAULT_PORT }
        timeout  = opts.fetch(:timeout) { DEFAULT_TIMEOUT }
        password = opts.fetch(:password) { nil }
        database = opts.fetch(:database) { DEFAULT_DATABASE }
        name     = opts.fetch(:name) { nil }

        @inner_pool = HAJ::Jedis::Pool.new(
          config,
          host,
          port,
          timeout,
          password,
          database,
          name
        )
      end

      def hold
        connection = @inner_pool.resource

        yield connection
      ensure
        connection.close if connection
      end

    end

  end
end