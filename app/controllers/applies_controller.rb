class AppliesController < ApplicationController
  layout 'simple'
  def apply
    if request.get?
    elsif request.post?
      @apply = Apply.new(params[:apply])
      if @apply.save
        redirect_to :back, notice: "Thanks! Your request is in my priority list."
      else
        redirect_to :back, alert: "Apply error: #{@apply.errors.full_messages}"
      end
    end
  end
end
