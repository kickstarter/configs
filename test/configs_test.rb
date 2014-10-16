require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class ConfigsTest < Configs::TestCase
  def setup
    @_original_config_dir = Configs.config_dir
    @_original_environment = Configs.environment

    Configs.config_dir = Pathname.new(File.dirname(__FILE__) + '/config')
    Configs.environment = 'test'
    Configs.reload
  end

  should "find config/foo/test.yml" do
    with_config('foo/test.yml', :hello => 'world') do
      assert_equal 'world', Configs[:foo][:hello]
    end
  end

  should "find config/foo.yml with test key" do
    with_config('foo.yml', 'test' => {:hello => 'world'}) do
      assert_equal 'world', Configs[:foo][:hello]
    end
  end

  should "find config/foo.yml with :test key" do
    with_config('foo.yml', :test => {:hello => 'world'}) do
      assert_equal 'world', Configs[:foo][:hello]
    end
  end

  should "find config/foo/default.yml" do
    with_config('foo/default.yml', :hello => 'world') do
      assert_equal 'world', Configs[:foo][:hello]
    end
  end

  should "find config/foo.yml with default key" do
    with_config('foo.yml', 'default' => {:hello => 'world'}) do
      assert_equal 'world', Configs[:foo][:hello]
    end
  end

  should "find config/foo.yml with :default key" do
    with_config('foo.yml', :default => {:hello => 'world'}) do
      assert_equal 'world', Configs[:foo][:hello]
    end
  end

  should "not find missing config" do
    assert_raises(Configs::NotFound) { Configs[:unknown] }
  end

  should "support indifferent hash access" do
    with_config('foo.yml', 'test' => {:hello => 'world'}) do
      assert_equal 'world', Configs[:foo][:hello]
      assert_equal 'world', Configs[:foo]['hello']
    end
  end

  should "interpolate ERB" do
    assert_equal 3, Configs[:erb][:three]
  end

  def teardown
    Configs.config_dir = @_original_config_dir
    Configs.environment = @_original_environment
  end

  protected

  def with_config(path, contents, &block)
    path = Configs.config_dir.join(path).to_s
    begin
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') { |f| f << contents.to_yaml }
      yield
    ensure
      File.delete(path)
    end
  end
end
