class AppliesController < ApplicationController
  skip_before_filter :verify_code
  layout 'simple'
  def apply
    if request.get?
    elsif request.post?
      @apply = Apply.new(params[:apply])
      if @apply.save
        redirect_to :back, notice: "Thanks for trying Akita. We will send you code soon."
      else
        redirect_to :back, alert: "Apply error: #{@apply.errors.full_messages}"
      end
    end
  end
end
