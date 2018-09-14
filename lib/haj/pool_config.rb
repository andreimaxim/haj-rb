module HAJ
  class PoolConfig < Java::org.apache.commons.pool2.impl.GenericObjectPoolConfig

    # Default values taken from the Jedis PoolConfig
    DEFAULT_TESTS_WHILE_IDLE            = true
    DEFAULT_MIN_EVICTABLE_IDLE_TIME     = 60_000
    DEFAULT_TIME_BETWEEN_EVICTIONS_RUNS = 30_000
    DEFAULT_TESTS_PER_EVICTION_RUN      = -1

    # Supplemental default values that allow more fine-tuned configuration
    # of the connection pool
    DEFAULT_MAX_TOTAL = 8
    DEFAULT_MAX_IDLE  = 8

    def initialize(options = {})
      # Make sure that we're not forwarding the arguments to the parent class
      # as there are no constructors defined that accept a Hash/java.util.Map
      # as an argument
      super()

      self.max_total = options.fetch(:max_total) { DEFAULT_MAX_TOTAL }
      self.max_idle  = options.fetch(:max_idle) { DEFAULT_MAX_IDLE }

      self.test_while_idle =
        options.fetch(:test_while_idle) { DEFAULT_TESTS_WHILE_IDLE }

      self.min_evictable_idle_time_millis =
        options.fetch(:min_evictable_idle_time) { DEFAULT_MIN_EVICTABLE_IDLE_TIME }

      self.time_between_eviction_runs_millis =
        options.fetch(:time_between_eviction_runs) { DEFAULT_TIME_BETWEEN_EVICTIONS_RUNS }

      self.num_tests_per_eviction_run =
        options.fetch(:tests_per_eviction_run) { DEFAULT_TESTS_PER_EVICTION_RUN }
    end
  end
end