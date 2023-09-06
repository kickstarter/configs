# Configs

[![Test and Release](https://github.com/kickstarter/configs/actions/workflows/test-release.yml/badge.svg)](https://github.com/kickstarter/configs/actions/workflows/test-release.yml)

Loads and manages config/*.yml files.

Searches through a few locations to find the right environment config:

1. config/$name/$env.yml
2. config/$name.yml (with $env key)
3. config/$name/default.yml
3. config/$name.yml (with 'default' key)

## Installation

Add this line to your application's Gemfile:

    gem 'configs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install configs

## Usage

If you have a `config/foo.yml`, then anywhere you need to read the file
you can use `Configs[:foo]` as a hash.

Example:

    # config/foo.yml
    development:
      hello: world

    # Elsewhere (even in a config/initializer)
    Configs[:foo][:hello]
    => 'world'

You can include ERB in the YAML files:

    # config/foo.yml
    development:
      database_password: <%= ENV['DATABASE_PASSWORD'] %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright 2014 Kickstarter, Inc

Released under an [MIT License](http://opensource.org/licenses/MIT)
