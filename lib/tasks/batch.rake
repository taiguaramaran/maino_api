namespace :batch do
  require 'rest-client'
  require 'json'
  desc "TODO"
  task get_data_from_api: :environment do
    p 'TESTEEEEEEEEEEEEEEEEEEEEEEEE'
    url = "https://api.spaceflightnewsapi.net/v3/articles"
    api_data = RestClient.get(url, { :content_type => :json})
    api_parse = JSON.parse(api_data)
    api_parse.each do |row|
      a = {:id => row['article_id'], :title => row['title'], :url => row['url'], :imageUrl => row[':imageUrl'], :newsSite => row['newsSite'],
           :summary => row['summary'], :publishedAt => row['publishedAt'], :updatedAt => row['updatedAt'], :featured => row['featured'],
           :launches => row['launches'], :events => row['events']}
      article_save = Article.where(article_id: row['id']).first_or_create(a)
      puts article_save.id

      row['launches'].each do |launch|
        b = {:id => launch['idLaunch'], :provider => launch['provider'], :article_id => article_save.id}
        Launch.where(id: launch['idLaunch']).first_or_create(b)
      end

      row['events'].each do |event|
        c = {:id => event['idEvent'], :provider => event['provider'], :article_id => article_save.id}
        Event.where(id: event['idEvent']).first_or_create(c)
      end

    end
  end
end