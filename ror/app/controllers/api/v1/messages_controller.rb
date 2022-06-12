module Api
  module V1
    class MessagesController < BaseController
      # Callbacks
      before_action :set_chat
      before_action :set_message, only: %i[show]

      # GET /applications/:token/chats/:number/messages
      def index
        @messages = @chat.messages.all
        render json: MessagesRepresenter.new(@messages).as_json
      end

      # GET /applications/:token/chats/:number/messages/:number
      def show
        render json: MessagesRepresenter.new(@messages).as_json
      end

      # POST /applications/:token/chats/:number/messages
      def create
        @message = @chat.messages.new number: (@chat.messages_count + 1), body: params[:body]
        if @message.save
          @chat.update messages_count: (@chat.messages_count + 1)
          render json: MessagesRepresenter.new(@message).as_json, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      private

      def set_chat
        @chat = Chat.joins(:application).where('applications.token' => params[:application_token])
                    .find_by! number: params[:chat_number]
      end

      def set_message
        @message = @chat.messages.find_by! number: params[:number]
      end
    end
  end
end
