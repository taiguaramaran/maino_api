namespace :batch do
  require 'rest-client'
  require 'json'
  desc "TODO"
  task get_data_from_api: :environment do
    url = "https://api.spaceflightnewsapi.net/v3/articles"
    api_data = RestClient.get(url, { :content_type => :json})
    api_parse = JSON.parse(api_data)
    api_parse.each do |row|
      api_registers = {:id => row['article_id'], :title => row['title'], :url => row['url'], :imageUrl => row[':imageUrl'], :newsSite => row['newsSite'],
           :summary => row['summary'], :publishedAt => row['publishedAt'], :updatedAt => row['updatedAt'], :featured => row['featured']}
      article_save = Article.where(article_id: row['id']).first_or_create(api_registers)

      row['launches'].each do |launch|
        api_launches = {:id => launch['idLaunch'], :provider => launch['provider'], :article_id => article_save.id}
        Launch.where(id: launch['idLaunch']).first_or_create(api_launches)
      end

      row['events'].each do |event|
        api_events = {:id => event['idEvent'], :provider => event['provider'], :article_id => article_save.id}
        Event.where(id: event['idEvent']).first_or_create(api_events)
      end

    end
  end
end
