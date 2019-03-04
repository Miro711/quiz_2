class ReviewsController < ApplicationController
  
  before_action :authenticate_user!
  def create
    @idea = Idea.find(params[:idea_id])
    @review = Review.new review_params
    @review.idea = @idea
    @review.user = current_user
    if @review.save
      redirect_to @idea
    else
      @reviews = @ideas.reviews.order(created_at: :desc)
      render "ideas/show"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to @review.idea
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end
end
