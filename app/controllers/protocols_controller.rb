
require 'pp'

class ProtocolsController < ApplicationController
  before_action :set_protocol, only: [:show, :edit, :update, :destroy]

  # GET /protocols
  # GET /protocols.json
  def index
    @protocols = Protocol.all
  end

  # GET /protocols/1
  # GET /protocols/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.pdf do
        send_data @protocol.to_pdf!, filename: @protocol.filename, type: 'application/pdf'
      end
    end
  end

  # GET /protocols/new
  def new
    @protocol = Protocol.new
    @protocol.topics.build
  end

  # GET /protocols/1/edit
  def edit
    @protocol = Protocol.find(params[:id])
    pp @protocol
    if @protocol.topics.last.valid?
      @protocol.topics.build
      @protocol.topics.last.topic_tags.build
      puts @protocol.topics.last.inspect
    end
  end

  # POST /protocols
  # POST /protocols.json
  def create
    @protocol = Protocol.new(protocol_params)
    respond_to do |format|
      if @protocol.save
        format.html { redirect_to @protocol, notice: 'Protocol was successfully created.' }
        format.json { render :show, status: :created, location: @protocol }
      else
        format.html { render :new }
        format.json { render json: @protocol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /protocols/1
  # PATCH/PUT /protocols/1.json
  def update
    respond_to do |format|
      if @protocol.update(protocol_params)
        format.html { redirect_to @protocol, notice: 'Protocol was successfully updated.' }
        format.json { render :show, status: :ok, location: @protocol }
      else
        format.html { render :edit }
        format.json { render json: @protocol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /protocols/1
  # DELETE /protocols/1.json
  def destroy
    @protocol.destroy
    respond_to do |format|
      format.html { redirect_to protocols_url, notice: 'Protocol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_protocol
      @protocol = Protocol.find(params[:id])
#      @pro_tags = @protocol.tags
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def protocol_params
      params.require(:protocol)
	.permit(:creator, :dateCreated, :dateSent, :text,
		topics_attributes: [:id, :headline, :text, :protocol_id,
			topic_tags_attributes: [:id, :tag_id, :topic_id]])
    end
end
