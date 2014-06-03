class UsersController < ApplicationController
	before_action :signed_in_user, 	only: [:index, :edit, :update, :destroy]
	before_action :correct_user, 		only: [:edit, :update]
	before_action :admin_user,			only: :destroy

  def new
  	@user = User.new
  end

  def index
  	@users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Boooyah, you're a real user now!  Thanks #{@user.name}."
			redirect_to @user
		else
			flash[:error] = "Uh-oh.  Something happened, and your account was destroyed in a massive explosion.  See below for details."
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated!"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted! (Yayyy, fuck them.)"
		redirect_to users_url
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Before filter methods!  Wahooooooooo

		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_url, notice: "What the hell do you think you're doing?!" unless current_user?(@user)
		end

		def admin_user
			redirect_to root_url, notice: "What the hell do you  think you're doing?!" unless current_user.admin?
		end
end
