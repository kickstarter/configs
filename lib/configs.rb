require "yaml"
require "erb"
require "configs/version"
require "configs/railtie" if defined? Rails

require 'active_support/core_ext/hash/indifferent_access'

module Configs
  class NotFound < StandardError;
    def initialize(name, env)
      super "could not find #{name} settings for :#{env} environment"
    end
  end

  class << self

    # Where the wild .yml live.
    # In a Rails app, this is Rails.root.join('config')
    attr_accessor :config_dir

    # The name of our environment.
    # In a Rails app, this is Rails.env
    attr_accessor :environment

    # will find (and memoize) the yml config file with this name
    #
    # cascades through a loading order to find the most specific yml file available (see Configs.load)
    #
    # if none can be found, it will raise an error
    def [](name)
      @_configs ||= {}
      @_configs[name.to_sym] ||= load(name)
    end

    def inspect
      @_configs.inspect
    end

    def reload
      @_configs = {}
    end

    protected

    # checks loading order for named yml file
    #
    # 1) `config/$NAME/$ENV.yml'
    # 2) `config/$NAME.yml' with $ENV key
    # 3) `config/$NAME.yml' with 'default' key
    def load(name)
      yml_file("#{name}/#{environment}") ||
        yml_file_with_key("#{name}", environment) ||
        yml_file("#{name}/default") ||
        yml_file_with_key("#{name}", 'default') ||
        raise(NotFound.new(name, environment))
    end

    def yml_file(name)
      path = config_dir.join(name + '.yml')
      contents = ERB.new(File.read(path)).result(binding)
      YAML.load(contents).with_indifferent_access
    rescue Errno::ENOENT
      # If file is missing, return nil
      nil
    end

    def yml_file_with_key(path, key)
      hash = yml_file(path)
      hash && hash[key]
    end

  end
end
