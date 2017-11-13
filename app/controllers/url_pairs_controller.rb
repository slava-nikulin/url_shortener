class UrlPairsController < ApplicationController
  def index
    @url_pairs = UrlPair.all.order(:created_at)
  end

  def create
    @url_pair = UrlPair.create(url_pair_params)
  end

  private

  def url_pair_params
    params.require(:url_pair).permit(:original_url, :short_path)
  end
end
