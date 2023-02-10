class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session

	def index
		@user = User.find_by(email: params[:email])
		@user_response={:fulname=>"#{@user.first_name} #{@user.last_name}",:age=>"#{@user.age}"}
		render json: @user_response
	end

 def create
		@user = User.new(user_params)
		if @user.save
				render json: @user
		else
				render error: {error: "unable create user"},status:400
		end
 end
 def update
	@user=User.find( params[:id])
	if @user
			@user.update(user_params)
			render json:{message:"user is update "},status:200
	else
			render json:{error:"error no update"},status:400
	end
end

def destroy
	@user=User.find(params[:id])
	if @user
			@user.destroy
			render json:{message:"user is success delete"},status:200
	else
			render json:{error:"unable destroy "},status:400
	end
end


  private

  def user_params
		params.require(:user).permit(:first_name,:last_name,:age,:email)
  end
end
