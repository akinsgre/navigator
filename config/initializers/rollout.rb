require 'redis'
#'redis://username:password@my.host:6389'

uri = URI.parse(ENV["REDISTOGO_URL"])
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
$rollout = Rollout.new($redis)

