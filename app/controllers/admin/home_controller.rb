class Admin::HomeController < AdminController
  protect_from_forgery with: :exception
  def index
  end
end
