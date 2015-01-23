class AccountActivationsController < ApplicationController

  before_action :admin_user,     only: [:destroy, :index]

  def edit
    user = User.find_by(id: params[:id])
    if user && !user.activated?
      user.update_attribute(:activated,    true)
      flash[:success] = "Account activated!"
      redirect_to users_path
    end
  end
  
  def admin_user
    redirect_to users_path unless logged_in? && current_user.admin?
  end

end
