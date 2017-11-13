module External
  # Public: Static Class, that checks URL for reachability. Uses wget
  #
  # Example:
  # => External::UrlChecker.working_url?("https://ya.ru")
  # => true
  # => External::UrlChecker.working_url?("ya.ru/wrong")
  # => false
  class UrlChecker
    class << self
      def working_url?(url)
        res = %x(
          if wget -S --spider #{url_with_scheme(url)} 2>&1 | grep 'HTTP/1.1 200 OK' -q -i;
            then printf 'true';
            else printf 'false';
          fi
        )
        res == "true"
      rescue => error
        Rails.logger.tagged("UrlChecker") do
          Rails.logger.error error.message
          Rails.logger.error error.backtrace.join("\n")
        end
        return false
      end

      private

      def url_with_scheme(url)
        url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//] ? url : "http://#{url}"
      end
    end
  end
end
