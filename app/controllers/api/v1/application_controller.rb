module Api
  module V1
    class ApplicationController < ::ApplicationController
      def authenticate_user!
        if session[:user_id]
          current_user
        else
          render json: { message: 'Invalid credentials' }
        end
      end
    end
  end
end
