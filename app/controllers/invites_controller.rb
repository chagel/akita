class InvitesController < ApplicationController
  skip_before_filter :verify_code
  before_filter :authenticate_user!
  layout 'simple'

  def create
    begin
      @invite = Invite.available.find_by(code: params[:invite]['code'])
      @invite.update_attributes activated_user_id: current_user.id, activated_at: Time.now
      redirect_to root_path, notice: "Welcome! In Akita we play with <a href='javascript:void(0)' class='gray shortcuts'>keyboard</a> !"
    rescue Mongoid::Errors::DocumentNotFound
      redirect_to :back, alert: 'Code is incorrect!'  
    end
    
  end
end
