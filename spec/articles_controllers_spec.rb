require 'rails_helper'
require 'swagger_helper'

describe 'RSPEC UNIT TESTS', type: :request do
  it 'returns all articles' do
    get 'https://localhost:3000/articles'
  expect(response).to have_http_status(:success)
  end
end

describe 'POST /articles' do
  let(:url){'https://localhost:3000/articles'}
  let(:params){{article: {article_id: '123', title:'teste', url: 'teste', imageUrl:'teste', newsSite:'teste', summary:'teste', publishedAt:'teste', updatedAt:'teste', featured:'teste'}}}
  it 'create status OK' do
    expect{post(url,params: params).to have_http_status(:success)}
  end

  it 'create a article' do
    expect{post(url,params: params).to change(Article, :count).by(1)}
  end
end

describe 'DELETE /articles/:id' do
  it 'delete a article' do
    expect{delete("https://localhost:3000/articles/#{article.id}").to change(Article, :count).by(0)}
  end
end

describe 'UPDATE /article/:id' do
  let(:url){"https://localhost:3000/articles/#{article.id}"}
  let(:params){{article: {article_id: '1234', title:'teste1', url: 'teste1', imageUrl:'teste', newsSite:'teste', summary:'teste', publishedAt:'teste', updatedAt:'teste', featured:'teste'}}}

  it 'update status success' do
    expect{put(url,params: params).to have_http_status(:success)}
  end

  it 'update a article' do
   expect{put(url,params: params).to change(article, :updated_at)}
  end
end
