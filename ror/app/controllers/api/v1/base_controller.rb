module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_entity

      def render_not_found_entity(_exception)
        render json: { message: 'resource not found' }, status: :not_found
      end
    end
  end
end
