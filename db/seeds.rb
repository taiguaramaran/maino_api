url = "https://api.spaceflightnewsapi.net/v3/articles"
api_data = RestClient.get(url, { :content_type => :json})
api_parse = JSON.parse(api_data)
api_parse.each do |row|
  api_data = {:id => row['article_id'], :title => row['title'], :url => row['url'], :imageUrl => row[':imageUrl'], :newsSite => row['newsSite'],
              :summary => row['summary'], :publishedAt => row['publishedAt'], :updatedAt => row['updatedAt'], :featured => row['featured']}
  article_save = Article.where(article_id: row['id']).first_or_create(api_data)

  row['launches'].each do |launch|
    api_launch = {:id => launch['idLaunch'], :provider => launch['provider'], :article_id => article_save.id}
    Launch.where(id: launch['idLaunch']).first_or_create(api_launch)
  end

  row['events'].each do |event|
    api_event = {:id => event['idEvent'], :provider => event['provider'], :article_id => article_save.id}
    Event.where(id: event['idEvent']).first_or_create(api_event)
   end

end
