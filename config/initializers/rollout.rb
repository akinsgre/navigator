require 'redis'
#'redis://username:password@my.host:6389'

uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/" )
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
$rollout = Rollout.new($redis)
$rollout.deactivate(:facebook)

REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)



