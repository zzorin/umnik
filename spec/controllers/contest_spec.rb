require 'rails_helper'

RSpec.describe ContestsController, type: :controller do
  describe "#index", focus:true do
    context "as an administrator" do
      it "responds successfully" do
        user = FactoryBot.create(:administrator)
        allow(controller).to receive(:current_user).and_return(user)
        get :index
        expect(response).to be_successful
      end
    end
  end
end
