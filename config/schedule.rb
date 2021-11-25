#every 1.day, at: '9:00 am' do
  #runner "article.retrieve_results"
#end
set :environment, "development"
every 1.minute do
  rake "batch:get_data_from_api"
end
