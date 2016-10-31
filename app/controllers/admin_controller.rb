class AdminController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  layout "admin"
end
