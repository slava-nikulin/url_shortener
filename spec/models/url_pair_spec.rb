RSpec.describe UrlPair, type: :model do
  before { allow(External::UrlChecker).to receive(:working_url?).with(anything).and_return(true) }

  describe "validation" do
    it { should validate_uniqueness_of(:short_path) }
    it { should allow_value("https://www.avito.ru/rostov/komnaty/sdam/na_dlitelnyy_srok?user=1").for(:original_url) }
    it { should_not allow_value("https:/www.avito.vv").for(:original_url) }
    it { should_not allow_value("http:ya.ry").for(:original_url) }
  end

  describe "callbacks" do
    let(:url_pair) { build :url_pair, short_path: "", original_url: "ya.ru" }

    describe "before_save" do
      context "when short_path field is empty" do
        before { url_pair.save }

        it "saves with generated url" do
          expect(url_pair.short_path).not_to be_empty
        end
      end

      context "when short_path field is not empty" do
        before do
          url_pair.short_path = "test"
          url_pair.save
        end

        it "saves with generated url" do
          expect(url_pair.short_path).to eq "test"
        end
      end

      context "when scheme is absent for original url" do
        before { url_pair.save! }

        it "saves original with scheme" do
          expect(url_pair.original_url).to include("http")
        end
      end

      context "when scheme is present for original url" do
        let(:url_pair_with_scheme) { build :url_pair, short_path: "", original_url: "https://ya.ru" }
        before { url_pair_with_scheme.save! }

        it "saves original with scheme" do
          expect(url_pair_with_scheme.original_url).to include("https")
        end
      end
    end
  end
end
