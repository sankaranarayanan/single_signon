redis = YAML.load(ERB.new(File.read(Rails.root.join('config','redis.yml'))).result)[Rails.env]
Resque.redis = Redis.new(redis.symbolize_keys)
