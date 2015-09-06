require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @user.secrets.create(content:"secret1")
    @like = Like.create(user_id:@user.id, secret_id: Secret.first.id)
  end
  describe "when not logged in" do
  	before do
      session[:user_id] = nil
    end
    controller SecretsController do
    	def index
    	end
    	def create
    	end
    	def destroy
    	end
	end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access create" do
      post :create
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access destroy" do
      delete :destroy, id: @like
      expect(response).to redirect_to('/sessions/new')
    end
  end
end