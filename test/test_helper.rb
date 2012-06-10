require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)

require 'test/unit'
require 'active_support/core_ext/hash/keys'

class Configs::TestCase < Test::Unit::TestCase
  def default_test; end # quiet Test::Unit

  def self.should(name, &block) # very simple syntax
    define_method("test_should_#{name.gsub(/[ -\/]/, '_').gsub(/[^a-z0-9_]/i, '')}", &block)
  end
end

class Rails
  class << self
    def root
      @_root ||= Pathname.new(File.dirname(__FILE__))
    end

    def env
      'test'
    end
  end
end