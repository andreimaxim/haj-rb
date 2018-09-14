module HAJ
  class Client

    DEFAULT_HOST     = 'localhost'.freeze
    DEFAULT_PORT     = 6379
    DEFAULT_TIMEOUT  = 2000
    DEFAULT_DATABASE = 0

    # @param opts [Hash] Options to connect to the Redis database
    def initialize(opts = {})

      config = HAJ::PoolConfig.new(opts)

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

    def with_connection
      connection = @inner_pool.resource

      yield connection
    ensure
      connection.close if connection
    end

    def set(key, value)
      with_connection { |c| c.set(key, value) }
    end

    def get(key)
      with_connection { |c| c.get(key) }
    end

  end
end