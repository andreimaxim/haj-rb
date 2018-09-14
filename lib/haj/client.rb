module HAJ
  class Client


    # @param opts [Hash] Options to connect to the Redis database
    def initialize(opts = {})
      @pool = HAJ::Pool::Generic.new(opts)
    end

    def execute(method, *args)
      @pool.hold { |conn| conn.send(method, *args) }
    end

  end
end