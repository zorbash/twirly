require 'twirly'
require 'factory_girl'
require 'faker'

RSpec.configure do |config|
  # Formatting
  config.formatter = :documentation
  config.color_enabled = true

  # Filtering
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
  config.treat_symbols_as_metadata_keys_with_true_values = true

  Dir['./spec/support/**/*.rb'].each(&method(:require))
  Dir['./spec/factories/**/*.rb'].each(&method(:require))

  config.include FactoryGirl::Syntax::Methods
end
