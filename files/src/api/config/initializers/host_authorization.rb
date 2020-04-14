Rails.application.configure do
  # Whitelist our hostname in ActionDispatch::HostAuthorization
  config.hosts << 'obs-reviewlab.opensuse.org'
end
