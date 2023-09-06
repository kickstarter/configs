#!/usr/bin/env rake
require 'bundler/gem_tasks'

task :default => :test

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs      << 'test'
  t.test_files = FileList['test/*test.rb']
  t.verbose    = true
end

namespace :gem do
  require 'bundler/gem_tasks'

  @gem = "pkg/configs-#{ Configs::VERSION }.gem"

  desc "Push #{ @gem } to rubygems.org"
  task :push => %i[test build git:check] do
    sh %{gem push #{ @gem }}
  end
end

namespace :git do
  desc 'Check git workspace'
  task :check do
    sh %{git diff HEAD --quiet} do |ok|
      abort "\e[31mRefusing to continue - git workspace is dirty\e[0m" unless ok
    end
  end
end
