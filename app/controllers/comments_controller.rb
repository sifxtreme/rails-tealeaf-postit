class CommentsController < ApplicationController
	before_action :require_user
  
  def create

    # @post = Post.find(params[:post_id]);
    @post = Post.find_by(slug: params[:post_id]);

    @comment = Comment.new(comment_params);
    @comment.post = @post;
    @comment.user = current_user

  	if @comment.save
  		flash[:notice] = "Your post was created"
  		redirect_to post_path(@post)
  	else
  		render 'posts/show'
  	end

  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:notice] = "Your vote was counted"
    else
      # flash[:error] = "Your vote was not counted"
      # flash[:error] = @vote.errors.inspect
      flash[:error] = "You can only vote for <strong>that</strong> once".html_safe
    end

    redirect_to :back
  end

  private 
	  def comment_params
	  	params.require(:comment).permit(:body, :post_id);
	  end

end