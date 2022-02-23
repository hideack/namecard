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
    @keychain = Keychain.new(keychain_params)
    token = get_access_token

    respond_to do |format|
      @suzuri_response = @keychain.publish(token)

      if @suzuri_response
        format.html { redirect_to keychains_url, notice: "Keychain was successfully created." }
        format.json { render :show, status: :created, location: @keychain }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @keychain.errors, status: :unprocessable_entity }
      end
    end
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
      @suzuri_response = nil
    end

    # Only allow a list of trusted parameters through.
    def keychain_params
      params.require(:keychain).permit(:message, :pattern)
      params.fetch(:keychain, {}).permit(:message, :pattern)
    end
end
