RSpec.describe External::UrlChecker do
  describe "#working_url?" do
    context "when url is valid" do
      it "returns true" do
        expect(described_class.working_url?("https://www.avito.ru/rostov/komnaty/sdam/na_dlitelnyy_srok?user=1"))
          .to be_truthy
      end
    end

    context "when url is valid and scheme is http" do
      it "returns true" do
        expect(described_class.working_url?("ya.ru")).to be_truthy
      end
    end

    context "when url is vk.com" do
      it "returns true" do
        expect(described_class.working_url?("https://vk.com")).to be_truthy
      end
    end

    context "when url leads to large file" do
      it "checks fastly" do
        expect(described_class.working_url?("http://speedtest.ftp.otenet.gr/files/test1Gb.db")).to be_truthy
      end
    end

    context "when url is invalid" do
      it "returns false" do
        expect(described_class.working_url?("ya.ru/testest")).to be_falsey
      end
    end
  end
end
