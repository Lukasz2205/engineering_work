module Panel
  class BaseController < ApplicationController
    before_action :admin?

    layout 'layouts/administration'

    private

    def admin?
      redirect_to root_path if current_user.role == 'user'
    end
  end
end