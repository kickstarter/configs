require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)

require 'minitest/autorun'

class Configs::TestCase < Minitest::Test
  def self.should(name, &block) # very simple syntax
    define_method("test_should_#{name.gsub(/[ -\/]/, '_').gsub(/[^a-z0-9_]/i, '_')}", &block)
  end
end

