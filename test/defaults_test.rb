require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class DefaultsTest < Configs::TestCase
  def get_environment
    ENV['RACK_ENV'] ? ENV['RACK_ENV'] : 'default' 
  end

  should "have sane defaults" do
    assert_equal Pathname.new('./configs'), Configs.config_dir
    assert_equal get_environment, Configs.environment
  end
end
