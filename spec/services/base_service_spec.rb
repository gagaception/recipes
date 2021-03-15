require "rails_helper"

RSpec.describe BaseService, type: :service do
  context "Response" do
    it "should be a Struct" do
      expect(BaseService::Response.new).to be_a(Struct)
    end
    
    it "should respond to successful?" do
      expect(BaseService::Response.new).to respond_to(:successful?)
    end

    it "should respond to error" do
      expect(BaseService::Response.new).to respond_to(:error)
    end
    it "should respond to data" do
      expect(BaseService::Response.new).to respond_to(:data)
    end
  end
end
