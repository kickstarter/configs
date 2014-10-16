require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class DefaultsTest < Configs::TestCase
  should "have sane defaults" do
    assert_equal Pathname.new('./configs'), Configs.config_dir
    assert_equal 'default', Configs.environment
  end
end
