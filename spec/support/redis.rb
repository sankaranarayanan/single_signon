RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.before(:each, :redis) do |example|
    Redis.new.flushall
  end
end
