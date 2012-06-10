module Configs
  class Railtie < Rails::Railtie
    initializer 'configs.rails_settings' do
      Configs.config_dir = Rails.root.join('config')
      Configs.environment = Rails.env
    end
  end
end