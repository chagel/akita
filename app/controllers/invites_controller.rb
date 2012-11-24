class InvitesController < ApplicationController
  skip_before_filter :verify_code
  before_filter :authenticate_user!
  layout 'simple'

  def create
    begin
      @invite = Invite.find_by(code: params[:invite]['code'], activated_user_id: nil)
      @invite.update_attributes activated_user_id: current_user.id, activated_at: Time.now
      redirect_to root_path, success: "Welcome! Akita project is still under development, please send feedback to <a href='mailto:chagel@gmail.com' class='white'>me</a> !"
    rescue Mongoid::Errors::DocumentNotFound
      redirect_to :back, alert: 'Code is incorrect!'  
    end
    
  end
end
