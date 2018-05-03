class WidgetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  wrap_parameters false

  prepend_view_path 'app/components/widgets'

  after_action :allow_iframe, only: [:show]

  def index
    widgets = Widget.available(params)
    uri = URI.parse(request.original_url)
    uri.path = ''
    uri.query = nil
    respond_to do |format|
      format.js { render :index, layout: false, locals: { widgets: widgets, uri: uri } }
      format.html { render :index }
    end
  end

  def show
    widget = Widget.find(params[:name])
    widget.id = params[:id]
    if widget
      respond_to do |format|
        format.js { render :show, layout: false, locals: { widget: widget } }
        format.html { render template: widget.template, layout: false, locals: { widget: widget } }
        format.json {
          render json: widget.to_json
        }
      end
    else
      head 404
    end
  end
end
