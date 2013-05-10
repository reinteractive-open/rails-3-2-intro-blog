class PostsController < ApplicationController
  def index
    @posts = Post.published

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
      format.atom
    end
  end

  def show
    @post = Post.published.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
end
