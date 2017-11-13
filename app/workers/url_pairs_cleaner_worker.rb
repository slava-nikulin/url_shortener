require "sidekiq-scheduler"

class UrlPairsCleanerWorker
  include Sidekiq::Worker

  def perform
    pairs_to_delete = UrlPair.where(created_at: 100.years.ago..15.days.ago)
    Rails.logger.info "#{pairs_to_delete.count} UrlPairs cleaned"
    pairs_to_delete.delete_all
  end
end
