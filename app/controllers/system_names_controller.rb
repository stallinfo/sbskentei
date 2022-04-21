class SystemNamesController < ApplicationController
  before_action :set_system_name, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /system_names or /system_names.json
  def index
    @system_names = SystemName.all
    @disables = [0,0,0]
    @selected_item = 2
  end

  # GET /system_names/1 or /system_names/1.json
  def show
    @disables = [0,0,0]
    @selected_item = 2
  end

  # GET /system_names/new
  def new
    @system_name = SystemName.new
    @disables = [0,0,0]
    @selected_item = 2
  end

  # GET /system_names/1/edit
  def edit
    @disables = [0,0,0]
    @selected_item = 2
  end

  # POST /system_names or /system_names.json
  def create
    @system_name = SystemName.new(system_name_params)
    @disables = [0,0,0]
    @selected_item = 2
    respond_to do |format|
      if @system_name.save
        format.html { redirect_to system_name_url(@system_name), notice: "System name was successfully created." }
        format.json { render :show, status: :created, location: @system_name }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @system_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_names/1 or /system_names/1.json
  def update
    @disables = [0,0,0]
    @selected_item = 2
    respond_to do |format|
      if @system_name.update(system_name_params)
        format.html { redirect_to system_name_url(@system_name), notice: "System name was successfully updated." }
        format.json { render :show, status: :ok, location: @system_name }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @system_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_names/1 or /system_names/1.json
  def destroy
    @disables = [0,0,0]
    @selected_item = 2
    @system_name.destroy

    respond_to do |format|
      format.html { redirect_to system_names_url, notice: "System name was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_name
      @system_name = SystemName.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def system_name_params
      params.require(:system_name).permit(:content, :user_id)
    end
end
