module Configs
  class Railtie < Rails::Railtie
    config.before_configuration do
      Configs.config_dir = Rails.root.join('config')
      Configs.environment = Rails.env
    end
  end
end
