# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_authorization
  helper_method :current_user

  layout :layout

  rescue_from ActiveRecord::RecordNotFound, with: :render_page404

  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    if respond_to?(:show)
      flash.now[:error] = t('app.messages.cannot_delete_record')
      next show
    end

    raise exception
  end

  private

  def require_authorization
    unless ControllerAcl.new(request).authorized?(current_user)
      redirect_to('/', flash: { error: t('app.messages.access_denied') })
    end
  end

  def current_user
    @current_user ||= UserSessionService.new(session: session).current_user
  end

  def render_page404(_error)
    render 'application/404', status: :not_found
  end

  def paginate(scope)
    scope.page(params[:page]).per(params[:per_page])
  end

  def layout
    current_user ? 'application' : 'public'
  end

  def routes
    @routes ||= Routes.new
  end

  def export_pdf(file_name, options = {})
    default_options = {
      pdf: file_name,
      layout: 'pdf',
      header: {
        right: t('app.messages.page_x_of_y', x: '[page]', y: '[topage]'),
        font_size: 6
      }
    }

    render(default_options.merge(options))
  end
end
