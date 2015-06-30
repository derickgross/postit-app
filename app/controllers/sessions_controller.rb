class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.where(username: params[:username]).first
		if user && user.authenticate(params[:password])
			if user.two_factor_auth?
				session[:two_factor] = true
				user.generate_pin!
				redirect_to pin_path
			else
				login_user!(user)
			end
		else
			flash.now[:error] = "There is an error with your username or password."
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash["notice"] = "You have logged out."
		redirect_to root_path
	end

	def pin
		access_denied unless session[:two_factor] == true

		if request.post?
			user = User.find_by pin: params[:pin]
			if user
				session[:two_factor] = nil
				user.remove_pin!
				login_user!(user)
			else
				flash[:error] = "There was an error with your log in attempt."
				redirect_to pin_path
			end
		end
	end

end