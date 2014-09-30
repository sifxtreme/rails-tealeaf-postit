class CommentsController < ApplicationController
	before_action :require_user
  
  def create

    @post = Post.find(params[:post_id]);

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

  private 
	  def comment_params
	  	params.require(:comment).permit(:body, :post_id);
	  end

end