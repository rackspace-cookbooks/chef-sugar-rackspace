require 'rspec'
require 'chefspec'
require 'chef/sugar/rackspace'

RSpec.configure do |config|
  config.expect_with :rspec do |spec|
    spec.syntax = :expect
  end

  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true

  config.log_level = :fatal
end
