class FeedbacksController < ApplicationController

  def new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      redirect_to root_url, notice: 'Feedback has been submitted successfully'
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content)
  end
end
