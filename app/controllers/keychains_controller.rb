class KeychainsController < ApplicationController
  before_action :set_keychain, only: %i[ show edit update destroy ]
  include AuthHelper

  # GET /keychains or /keychains.json
  def index
    @keychains = Keychain.all
  end

  # GET /keychains/1 or /keychains/1.json
  def show
  end

  # GET /keychains/new
  def new
    @keychain = Keychain.new
  end

  # GET /keychains/1/edit
  def edit
  end

  # POST /keychains or /keychains.json
  def create
    require 'mini_magick'
    image = MiniMagick::Image.open("./app/assets/images/860x860.png")

    image.combine_options do |config|
      config.font "./app/assets/fonts/VL-PGothic-Regular.ttf"
      config.pointsize 48
      config.fill "#ff0000"
      config.gravity "center"
      config.draw "text 0,0 Hello!SUZURI"
    end

    temp_file = "./storage/#{SecureRandom.hex}.png"
    image.write temp_file
    logger.debug(temp_file)

    token = get_access_token
    record = {
      :texture => temp_file,
      :title => "れんしゅうそのいち",
      :price => 2000,
      :description => "API経由で作成",
      :products => [
        :itemId => 147,
        :exemplaryItemVariantId => 1952,
        :published => true,
        :resizeMode => "contain",
      ]
    }

    response = token.post(
      "https://suzuri.jp/api/v1/materials",
      {:body => record.to_json, :headers => {'Authorization' => "Bearer #{token.token}", 'Content-Type' => 'application/json'}}
    )

    logger.debug(response.status)
    logger.debug(response.body)

#    @keychain = Keychain.new(keychain_params)
#
#    respond_to do |format|
#      if @keychain.save
#        format.html { redirect_to keychain_url(@keychain), notice: "Keychain was successfully created." }
#        format.json { render :show, status: :created, location: @keychain }
#      else
#        format.html { render :new, status: :unprocessable_entity }
#        format.json { render json: @keychain.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # PATCH/PUT /keychains/1 or /keychains/1.json
  def update
    respond_to do |format|
      if @keychain.update(keychain_params)
        format.html { redirect_to keychain_url(@keychain), notice: "Keychain was successfully updated." }
        format.json { render :show, status: :ok, location: @keychain }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @keychain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keychains/1 or /keychains/1.json
  def destroy
    @keychain.destroy

    respond_to do |format|
      format.html { redirect_to keychains_url, notice: "Keychain was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keychain
      @keychain = Keychain.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def keychain_params
      params.fetch(:keychain, {})
    end
end
