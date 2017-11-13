class RedirectController < ApplicationController
  before_action do
    @url_pair = UrlPair.find_by(short_path: params[:short_path])
  end

  def perform
    return render_404 unless @url_pair
    @url_pair.update_attributes!(clicks_count: @url_pair.clicks_count + 1)
    redirect_to @url_pair.original_url
  end
end
