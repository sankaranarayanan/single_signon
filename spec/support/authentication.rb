RSpec.configure do |c|
  c.before(:each, :omniauth) do |example|
    OmniAuth.config.test_mode = true
  end

  c.after(:each, :omniauth) do |example|
    OmniAuth.config.test_mode = false
  end
end
