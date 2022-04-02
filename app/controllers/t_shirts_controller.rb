class TShirtsController < ApplicationController
  before_action :set_t_shirt, only: %i[ show edit update destroy ]
  include AuthHelper

  # GET /t_shirts or /t_shirts.json
  def index
    @t_shirts = TShirt.all
  end

  # GET /t_shirts/1 or /t_shirts/1.json
  def show
  end

  # GET /t_shirts/new
  def new
    @t_shirt = TShirt.new
  end

  # GET /t_shirts/1/edit
  def edit
  end

  # POST /t_shirts or /t_shirts.json
  def create
    @t_shirt = TShirt.new(t_shirt_params)
    token = get_access_token

    respond_to do |format|
      suzuri_response = @t_shirt.publish(token)

      if suzuri_response
        format.html { redirect_to t_shirt_url(@t_shirt), notice: "T shirt was successfully created." }
        format.json { render :show, status: :created, location: @t_shirt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @t_shirt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /t_shirts/1 or /t_shirts/1.json
  def update
    respond_to do |format|
      if @t_shirt.update(t_shirt_params)
        format.html { redirect_to t_shirt_url(@t_shirt), notice: "T shirt was successfully updated." }
        format.json { render :show, status: :ok, location: @t_shirt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @t_shirt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /t_shirts/1 or /t_shirts/1.json
  def destroy
    @t_shirt.destroy

    respond_to do |format|
      format.html { redirect_to t_shirts_url, notice: "T shirt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t_shirt
      @t_shirt = TShirt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def t_shirt_params
      params.require(:t_shirt).permit(:message, :pattern)
    end
end
