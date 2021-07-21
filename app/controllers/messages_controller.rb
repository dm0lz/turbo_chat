# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[show edit update destroy]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show; end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit; end

  # POST /messages or /messages.json
  def create
    # binding.pry
    @message = current_user.messages.build(message_params)

    respond_to do |format|
      if @message.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_message', partial: 'messages/new_form', locals: { message: Room.find(@message.room.id).messages.build }), content_type: 'text/vnd.turbo-stream.html' }
        format.html { redirect_to [@message.room, @message], notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_message', partial: 'messages/new_form', locals: { message: Room.find(@message.room.id).messages.build }), content_type: 'text/vnd.turbo-stream.html' }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        # format.turbo_stream { render turbo_stream: turbo_stream.replace('new_message', partial: 'messages/message', locals: { message: @message }), content_type: 'text/vnd.turbo-stream.html' }
        format.html { redirect_to [@message.room, @message], notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to room_url(@message.room), notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:room_id, :body)
  end
end
