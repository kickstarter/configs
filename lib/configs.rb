require "configs/version"

module Configs
  class NotFound < StandardError; end

  class << self

    # will find (and memoize) the yml config file with this name
    #
    # cascades through a loading order to find the most specific yml file available (see Configs.load)
    #
    # if none can be found, it will raise an error
    def [](name)
      @_configs ||= {}
      @_configs[name.to_sym] ||= load(name).symbolize_keys
    end

    def inspect
      @_configs.inspect
    end

    protected

    # checks loading order for named yml file
    #
    # 1) `config/$NAME/$ENV.yml'
    # 2) `config/$NAME.yml' with $ENV key
    # 3) `config/$NAME.yml' with 'default' key
    def load(name)
      yml_file("config/#{name}/#{Rails.env}") ||
        yml_file_with_key("config/#{name}", Rails.env) ||
        yml_file("config/#{name}/default") ||
        yml_file_with_key("config/#{name}", 'default') ||
        raise(NotFound)
    end

    def yml_file(name)
      path = Rails.root.join(name + '.yml')
      YAML.load_file path if File.exists? path
    end

    def yml_file_with_key(path, key)
      hash = yml_file(path)
      hash && hash[key]
    end

  end
end