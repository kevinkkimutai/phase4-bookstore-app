class UsersController < ApplicationController

  skip_before_action :authorize_request, only: :create
  def create
    user = User.new(user_params)
    if user.save
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
      
      render json: {user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
    
      private
    
      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end
end
