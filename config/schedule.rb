set :environment, "development"
every 1.day, at: '9:00 am' do
  rake "batch:get_data_from_api"
end
