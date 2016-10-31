module Admin::UsersHelper

  def show_status user
    if user.admin?
      t "status.success"
    else
      t "status.warning"
    end
  end
end
