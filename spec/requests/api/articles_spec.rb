require 'swagger_helper'

RSpec.describe "Swagger Documentation", type: :request do

  path '/articles' do
    get 'Retrieves all articles' do
    response '200', 'Articles Found' do
      run_test!
     end
    end
  end

  path '/' do
    get 'Show the Challenge' do
      response '200', 'Welcome to Back-end Challenge 2021 🏅 - Space Flight News' do
        run_test!
      end
    end
  end

  path '/articles/{id}' do
    get 'Retrieves an Article' do
      parameter name: :id, :in => :path, :type => :string
      response '200', 'Article Found' do
        let(:id) { Article.create(title: 'teste').id }
        run_test!
      end

      response '404', 'Article not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/articles/{id}' do
    put 'Update an Article' do
      consumes 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string
      let(:id) { Article.create(title: 'teste').id }
      parameter name: :article, in: :body, schema: {
      type: :object,
      properties: { title: { type: :string } },required: true }

      response '200', 'Article Found' do
        let(:article) { { title: 'new article' } }
        run_test!
      end
    end
  end


  path '/articles' do
    post 'Creates an Article' do
      consumes 'application/json', 'application/xml'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: { title: { type: :string } }, required: ['title'] }

      response '200', 'article created' do
        let(:article) { { title: 'new article' } }
        run_test!
      end
    end
  end

  path '/articles/{id}' do

    delete 'Deletes an Article' do
      produces 'application/json'
      description 'Deletes specific article'
      parameter name: :id, :in => :path, :type => :string
      let(:id) { Article.create(title: 'teste').id }

      response '200', 'article deleted' do
        run_test!
      end

      response '404', 'article not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
