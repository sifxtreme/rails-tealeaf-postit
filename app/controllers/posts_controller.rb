class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]

  def index
  	@posts = Post.all
    # @posts = Post.all.sort_by{|x| x.total_votes}.reverse

  end

  def show
    # puts Post.my_class_method
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json do
        render json: @post
      end
      format.xml do
        render xml: @post
      end
      # format.xml { render xml: @post}
    end
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
    @post.creator = current_user

  	if @post.save
  		flash[:notice] = "Your post was created"
  		redirect_to posts_path
  	else
  		render :new
  	end

  end

  def edit
  end

  def update
  	if @post.update(post_params)
  		flash[:notice] = "Your post was updated"
  		redirect_to posts_path
  	else
  		render :edit
  	end
  end

  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])

    respond_to do |format|
      format.html {
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          # flash[:error] = "Your vote was not counted"
          flash[:error] = "You can only vote for <strong>that</strong> once".html_safe
        end

        redirect_to :back
      }
      format.js
    end

    
  end

  private 
	  def post_params
	  	params.require(:post).permit(:title, :url, :description, category_ids: [])
	  end

	  def set_post
	  	# @post = Post.find(params[:id])
      @post = Post.find_by(slug: params[:id])
	  end

end
