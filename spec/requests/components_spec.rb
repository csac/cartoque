require 'spec_helper'

describe "Components" do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as user }

  describe "GET /components" do
    it "list all components" do
      get components_path
      response.status.should be(200)
    end
  end
end
