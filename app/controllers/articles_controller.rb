class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def home
    render json: "Back-end Challenge 2021 🏅 - Space Flight News", status: :ok
  end

  def index
    vars = request.query_parameters
    if vars['page'].nil?
      page = 0
    else
      page = params.fetch(:page).to_i
    end

    if vars['limit'].nil?
      limit = 10
    else
      limit = params.fetch(:limit).to_i
    end

    article = Article.offset(page * limit).limit(limit).includes(:launch, :event)
    render json: article.to_json(
                                 include: {
                                 launch: { only: [:id, :provider]},
                                 event: { only: [:id, :provider]}
                                 }), status: :ok
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: { status: 'SUCCESS', data: article }, status: :ok
    else
      render json: { status: 'ERROR'}, status: :not_found
    end
  end

  def show
    article = Article.includes(:event, :launch).find_by_id(params[:id])
    if !article.nil?
      render json: article.to_json(
                                   include: {
                                   launch: { only: [:id, :provider]},
                                   event: { only: [:id, :provider]}
                  }), status: :ok
    else
      render json: { status: 'ERROR', message: 'ID NOT FOUND' }, status: :not_found
    end
  end

  def destroy
    article = Article.find_by_id(params[:id])
    if !article.nil?
      Article.find(params[:id]).destroy!
      render json: { status: 'SUCCESS', message: 'Deleted', data: article }, status: :ok
    else
      render json: { status: 'ERROR', message: 'ID NOT FOUND' }, status: :not_found
    end
  end

  def update
    article = Article.find_by_id(params[:id])
    if !article.nil?
      if article.update_attributes(article_params)
        render json: { status: 'SUCCESS', message: 'Updated', data: article },status: :ok
      else
        render json: { status: 'ERROR',message: 'ID NOT FOUND' }, status: :not_found
      end
    else
      render json: { status: 'ERROR',message: 'ID NOT FOUND' }, status: :not_found
    end
  end


  private

  def article_params
    params.permit(:article_id, :title, :imageUrl, :newsSite, :summary, :publishedAt, :featured, :lauches, :event)
  end
end
