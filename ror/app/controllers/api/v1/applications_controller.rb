module Api
  module V1
    class ApplicationsController < BaseController
      # Callbacks
      before_action :set_application, only: %i[show update]

      # GET /applications
      def index
        @applications = Application.all
        render json: ApplicationsRepresenter.new(@applications).as_json
      end

      # GET /applications/:token
      def show
        render json: ApplicationsRepresenter.new(@application).as_json
      end

      # POST /applications
      def create
        @application = Application.new name: params[:name]
        if @application.save
          render json: ApplicationsRepresenter.new(@application).as_json, status: :created
        else
          render json: @application.errors, status: :unprocessable_entity
        end
      end

      # PUT /applications/:token
      # PATCH /applications/:token
      def update
        @application.name = params[:name]
        if @application.save
          render json: ApplicationsRepresenter.new(@application).as_json
        else
          render json: @application.errors, status: :unprocessable_entity
        end
      end

      private

      def set_application
        @application = Application.find_by! token: params[:token]
      end
    end
  end
end
