# Highly-Advanced Jedis client for Ruby

The raison d'être of this project can be pretty much described in one single
table:

```bash
# After 1M rows
 
                    user     system      total        real
Postgres        5.470000   0.020000   5.490000 (  5.304850)
Redis         280.990000  18.510000 299.500000 (298.341402)
JedisRb        14.840000  15.130000  29.970000 ( 56.725179)
Memory          0.270000   0.010000   0.280000 (  0.162491)
```

It looks slightly odd, but let's explain it a bit.

This is the result of a plain benchmark done on a Mac OS X development
machine using JRuby 9.2.0.0 and several libraries:

* [Sequel][sequel] with [jdbc-postgres][jdbc-pg] for the `Postgres` row
* Plain [redis-rb][redis-rb] for the `Redis` row
* For the `JedisRb` row the [jedis_rb][jedis_rb] gem was used, which is a simple wrapper over the [jedis][jedis] Java library
* Finally, `Memory` meant using a plain Ruby hash

[sequel]: https://github.com/jeremyevans/sequel/
[jdbc-pg]: https://github.com/jruby/activerecord-jdbc-adapter/tree/master/jdbc-postgres
[redis-rb]: https://github.com/redis/redis-rb
[jedis_rb]:https://github.com/asmallworldsite/jedis_rb/tree/master/lib/jedis_rb
[jedis]: https://github.com/xetorthio/jedis

For the test, a table was created in a Postgres database that looked like a key-value store, something along the lines of:

```sql
SQL
  CREATE TABLE IF NOT EXISTS things (
    k text,
    v text,
    PRIMARY KEY (k)
  );
  TRUNCATE TABLE things;
SQL
```

The SQL query used:

```sql
SELECT v FROM things WHERE k='#{random_key}';
```

The Redis query used:

```ruby
redis.get(random_key)
```

Redis should be faster, especially when used as a key-value store, but Postgres actually blew it out of the water in this little test, which seemed odd.

First, let's talk about the elephant in the room, in this case the significant amount of time required by [redis-rb][redis-rb]: it's a plain Ruby application and a lot of time is spent in userland (280 seconds out of the 298 seconds), while the other libraries use faster languages (Java bindings for both the JDBC driver and Jedis and JRuby optimizes the hash quite nicely).

So, in this case, the language was the bottleneck and maybe some gains can be achieved if the JRuby team will look into the redis-rb gem and suggest some optimizations.

However, it's not so obvious why [jedis_rb][jedis_rb] was so slow compared to [Sequel][sequel] + [jdbc-postgres][jdbc-pg], especially since it's relying on the pretty fast [jedis][jedis] Java library (which is also one of the recommended libraries by Redis).

In this case, the answer lies in the smaller `real` time than the `total` time, which probably means that there are things happening in parallel. So the answer is probably in the connection pool.

There are two things you can do with a connection pool:

1. Create a limited set of connections that can be reused by the application when needed.
2. Parallelize the requests, when possible.

The [Sequel][sequel] gem was doing both, while [jedis_rb][jedis_rb] didn't even an option to set the number of concurrent connections. Actually, when digging a bit through [Sequel][sequel] but also through [jedis][jedis], it becomes rather obvious that the [Sequel][sequel] developers spent a lot of time and effort to maximize the output of the library by using as many of the connections in the connection pool as possible.

This is where HAJ comes in.

The goal of this project is to have __a more advanced connection pool__ for Jedis which can take advantage of __multiple parallel connections__ to Redis and *dramatically* increase the output.

Obviously, this is a work in progress so please don't use it in production.