# Standard library
require 'singleton'

# All the Java jars that need to be loaded
require 'haj_jars'

require 'haj/version'

# Application files
require 'haj/client'
require 'haj/pool/generic'
require 'haj/pool/config'

module HAJ
  # Make the Jedis Java classes a bit more accessible.
  #
  # Normally this might make inspection a bit weird because inspecting a
  # `HAJ::Jedis::Client` object will actually return a
  # `Java::RedisClientsJedis::Jedis` object.
  #
  # However, since we're obviously working with Jedis, this convention will
  # probably look a lot better when reading the code so the previous point
  # will be probably less annoying.
  module Jedis

    Client = Java::RedisClientsJedis::Jedis
    # The Jedis default pool.
    Pool = Java::RedisClientsJedis::JedisPool
    Protocol = Java::RedisClientsJedis::Protocol
  end
end
