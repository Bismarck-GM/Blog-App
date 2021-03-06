class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :require_login, except: [:index]
  def index
    @articles = Article.all
  end

  def not_authenticated
    flash[:notice] = 'Login, naked fool'
    redirect_to main_app.login_path
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    flash.notice = "Article '#{@article.title}' Created!"
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.destroy(params[:id])
    flash.notice = "Article '#{@article.title}' Deleted!"
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end
end
