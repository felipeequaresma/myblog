RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.url_whitelist = ['postgres://postgres:password@db:5432']
    DatabaseCleaner.clean_with(:transaction)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
