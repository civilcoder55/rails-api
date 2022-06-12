module Api
  module V1
    class ChatsController < BaseController
      # Callbacks
      before_action :set_application
      before_action :set_chat, only: %i[show]

      # GET /applications/:token/chats
      def index
        @chats = @application.chats.all
        render json: ChatsRepresenter.new(@chats).as_json
      end

      # GET /applications/:token/chats/:number
      def show
        render json: ChatsRepresenter.new(@chat).as_json
      end

      # POST /applications/:token/chats/
      def create

        puts params
        @chat = @application.chats.new number: (@application.chats_count + 1)
        if @chat.save
          @application.update chats_count: (@application.chats_count + 1)
          render json: ChatsRepresenter.new(@chat).as_json, status: :created
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      private

      def set_application
        @application = Application.find_by! token: params[:application_token]
      end

      def set_chat
        @chat = @application.chats.find_by! number: params[:number]
      end
    end
  end
end
