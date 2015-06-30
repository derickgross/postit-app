class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find_by slug: params[:post_id]
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.user = current_user
		
		if @comment.save
			flash["notice"] = 'Your comment was added.'
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end

	def vote
		@comment = Comment.find(params[:id])
		@vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
		vote_type = nil

    respond_to do |format|
      format.html do
        if params[:vote] == "true"
          vote_type = "up"
        else
          vote_type = "down"
        end

        if @vote.valid?
          flash["notice"] = "Your #{vote_type} vote for the comment was counted."
        else
          flash[:error] = "You may only vote for a comment once."
        end
        redirect_to :back
      end
      format.js
    end
	end
end