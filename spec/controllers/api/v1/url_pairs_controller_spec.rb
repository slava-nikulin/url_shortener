RSpec.describe Api::V1::UrlPairsController, type: :controller do
  render_views

  describe "POST create" do
    let(:params) do
      {
        url_pair: {
          original_url: "ya.ru",
          short_path: "test",
        },
        format: :json,
      }
    end

    let(:parsed_response) { JSON.parse(response.body) }

    context "when params are correct" do
      it "has a 200 status code and creates url pair" do
        expect { post :create, params: params }.to change { UrlPair.count }.by(1)
        expect(response.status).to eq(200)
        expect(parsed_response["url_pair"]["original_url"]).to eq "http://ya.ru"
        expect(parsed_response["success"]).to be_truthy
        expect(parsed_response["errors"]).to be_empty
      end
    end

    context "when params are incorrect" do
      before { create :url_pair, original_url: "http://ya.ru" }

      it "has a 200 status code and returns errors" do
        expect { post :create, params: params }.to_not(change { UrlPair.count })
        expect(response.status).to eq(200)
        expect(parsed_response["url_pair"]["original_url"]).to eq "http://ya.ru"
        expect(parsed_response["success"]).to be_falsey
        expect(parsed_response["errors"]).not_to be_empty
      end
    end
  end
end
