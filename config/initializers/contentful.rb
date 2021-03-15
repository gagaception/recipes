Rails.application.eager_load!

#eager-loading referenced classes
ContentfulModel::Base.descendents.each do |klass|
  klass.send(:add_entry_mapping)
end

ContentfulModel.configure do |config|
  config.access_token = Rails.application.credentials[Rails.env.to_sym][:contentful][:access_token]
  config.space = Rails.application.credentials[Rails.env.to_sym][:contentful][:space_id]
  config.environment = "master"
end
