require 'vcr'

VCR.configure do |c|
  c.default_cassette_options = { :record => :once, :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:code)], :allow_playback_repeats => true }
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
