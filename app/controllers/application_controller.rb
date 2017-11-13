class ApplicationController < ActionController::Base
  def render_404
    Rails.logger.info "Rendering 404"
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end
