class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]
	def index
		@secrets = Secret.all
		@user = User.find(session[:user_id])
		@likes = Like.all
	end

	def create
		secret = User.find(session[:user_id]).secrets.new
		secret.content = params[:content]
		if !secret.save
			flash[:errors] = secret.errors.full_messages
		end
		redirect_to "/users/#{session[:user_id]}"
	end

	def destroy
		secret = Secret.find(params[:id])
		secret.destroy if secret.user == current_user

		redirect_to "/users/#{current_user.id}"
	end
end