class UrlPair < ApplicationRecord
  validates :original_url, :short_path, uniqueness: true
  validates_format_of :original_url,
    with: /\A((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validate :validate_original_url, on: %i(create update), if: :original_url_changed?

  before_validation do
    if original_url !~ /^https?:\/\//
      self.original_url = "http://#{original_url}"
    end
  end

  before_save do
    if short_path.blank?
      loop do
        self.short_path = generate_short_path
        break unless UrlPair.exists?(short_path: short_path)
      end
    end
  end

  private

  def generate_short_path
    shortener_config = Rails.application.config_for(:shortener)
    short_path_length =
      if shortener_config.blank? || shortener_config["short_path_length"].blank? ||
         shortener_config["short_path_length"] <= 0
        6
      end

    url_chars = [("a".."z"), ("A".."Z"), ("0".."9")].map(&:to_a).flatten
    (0...short_path_length).map { url_chars[rand(url_chars.length)] }.join
  end

  def validate_original_url
    errors.add(:original_url, "is not reachable") unless External::UrlChecker.working_url?(original_url)
  end
end
