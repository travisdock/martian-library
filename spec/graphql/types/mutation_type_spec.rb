require "rails_helper"

RSpec.describe Types::MutationType do
  describe "sign in" do
    let!(:user) { create(:user) }

    let(:mutation) do
      %(mutation {
        signIn(email: "#{user.email}"){
          token
        }
      })
    end

    subject(:result) do
      MartianLibrarySchema.execute(mutation).as_json
    end

    it "returns token for valid user" do
      expect(result.dig("data", "signIn", "token")).to eq(Base64.encode64(user.email))
    end
  end
end