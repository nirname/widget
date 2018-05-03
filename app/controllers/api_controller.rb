class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  wrap_parameters false

  prepend_view_path 'app/assets/javascripts'

  def api
    respond_to do |format|
      # format.js {
      #   if Rails.env.production?
      #     redirect_to ActionController::Base.helpers.asset_path("api.js", format: :js)
      #     redirect_to ActionController::Base.helpers.asset_path("/assets/api.js")
      #   else
      #     render file: 'api.js'
      #   end
      # }
      # format.js { redirect_to '/assets/api.js' }
      format.js { render file: 'api.js' }
    end
  end
end
