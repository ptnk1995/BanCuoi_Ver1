class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      if verify_admin_access?
        redirect_to admin_root_url
      else
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "index.invalid_value"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
