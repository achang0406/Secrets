class LikesController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]
	def like
		like = Like.create(user_id:session[:user_id], secret_id: params[:id])
		redirect_to '/secrets'
	end
	def dislike
		like = Like.find_by(user_id: session[:user_id], secret_id:params[:id])
		if like
			like.destroy
		end
		redirect_to '/secrets'
	end
end