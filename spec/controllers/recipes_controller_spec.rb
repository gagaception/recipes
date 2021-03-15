require "rails_helper"

RSpec.describe RecipesController, type: :controller do
  context "#index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns status 200" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  context "#show" do
    it "returns a success response" do
      get :show, params: { id: "4dT8tcb6ukGSIg2YyuGEOm" }
      expect(response).to be_successful
    end

    it "returns status 200" do
      get :show, params: { id: "4dT8tcb6ukGSIg2YyuGEOm" }
      expect(response).to have_http_status "200"
    end

    it "returns status 404" do
      get :show, params: { id: "randomid" }
      expect(response).to have_http_status "404"
    end
  end
end