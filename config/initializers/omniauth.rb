Rails.application.config.middleware.insert_before 0, OmniAuth::Builder do
end

OmniAuth.config.request_validation_phase = nil
OmniAuth.config.allowed_request_methods = [:get, :post]
OmniAuth.config.silence_get_warning = true

