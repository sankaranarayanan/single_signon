require 'rack/iframe'

Rails.application.config.middleware.insert_before ActionDispatch::Session::CookieStore, Rack::Iframe
