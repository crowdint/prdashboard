class Api::V1::ApplicationController < ApplicationController

  def authenticate_user!
    if session[:user_id]
      current_user
    else
      render json: { message: 'Invalid credentials' }
    end
  end

end

