class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def home
    render json: "Back-end Challenge 2021 🏅 - Space Flight News", status: :ok
  end

  def index
    render json: Article.all
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: { status: 'SUCCESS', message: 'Created', data: article }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Not Created' }, status: :unprocessable_entity
    end
  end

  def show
    article = Article.find_by_id(params[:id])
    if !article.nil?
      render json: { status: 'SUCCESS', message: 'Showed', data: article }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Not Showed' }, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find_by_id(params[:id])
    if !article.nil?
      Article.find(params[:id]).destroy!
      render json: { status: 'SUCCESS', message: 'Deleted', data: article }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Not Deleted' }, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find_by_id(params[:id])
    if !article.nil?
      if article.update_attributes(article_params)
        render json: { status: 'SUCCESS', message: 'Updated', data: article },status: :ok
      else
        render json: { status: 'ERROR', message: 'Not updated' }, status: :unprocessable_entity
      end
    else
      render json: { status: 'ERROR', message: 'Not updated' }, status: :unprocessable_entity
    end
  end


  private

  def article_params
    params.permit(:article_id, :title, :imageUrl, :newsSite, :summary, :publishedAt, :featured, :lauches, :event)
  end
end
