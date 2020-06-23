require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "#index" do
    it "responds successfully" do
      get '#index'
      expect(response).to be_successful
    end
  end

  describe "#instruction" do
    it "responds successfully" do
      get '#instruction'
      expect(response).to be_successful
    end
  end
end
