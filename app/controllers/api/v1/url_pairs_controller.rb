module Api
  module V1
    class UrlPairsController < ApiController
      def create
        @url_pair = UrlPair.create(url_pair_params)
      end

      private

      def url_pair_params
        params.require(:url_pair).permit(:original_url, :short_path)
      end
    end
  end
end
