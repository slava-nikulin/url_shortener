require "sidekiq/testing"

RSpec.describe UrlPairsCleanerWorker, type: :worker do
  Sidekiq::Testing.fake!
  before { allow(External::UrlChecker).to receive(:working_url?).with(anything).and_return(true) }

  describe "queueing" do
    it "increases job queue size" do
      expect { described_class.perform_async }.to change(UrlPairsCleanerWorker.jobs, :size).by(1)
    end
  end

  describe "#perform" do
    before { create :url_pair, created_at: Date.today - 20.days }

    it "deletes old url pairs" do
      expect { described_class.new.perform }.to change { UrlPair.count }.by(-1)
    end
  end
end
