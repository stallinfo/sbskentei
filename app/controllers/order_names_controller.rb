class OrderNamesController < ApplicationController
  before_action :set_order_name, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /order_names or /order_names.json
  def index
    @disables = [0,0,0]
    @selected_item = 2
    @order_names = OrderName.all.order(:system_name_id)
  end

  # GET /order_names/1 or /order_names/1.json
  def show
    @disables = [0,0,0]
    @selected_item = 2
  end

  # GET /order_names/new
  def new
    @disables = [0,0,0]
    @selected_item = 2
    @order_name = OrderName.new
  end

  # GET /order_names/1/edit
  def edit
    @disables = [0,0,0]
    @selected_item = 2
  end

  # POST /order_names or /order_names.json
  def create
    @disables = [0,0,0]
    @selected_item = 2
    @order_name = OrderName.new(order_name_params)

    respond_to do |format|
      if @order_name.save
        format.html { redirect_to order_name_url(@order_name), notice: "Order name was successfully created." }
        format.json { render :show, status: :created, location: @order_name }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_names/1 or /order_names/1.json
  def update
    @disables = [0,0,0]
    @selected_item = 2
    respond_to do |format|
      if @order_name.update(order_name_params)
        format.html { redirect_to order_name_url(@order_name), notice: "Order name was successfully updated." }
        format.json { render :show, status: :ok, location: @order_name }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_names/1 or /order_names/1.json
  def destroy
    @disables = [0,0,0]
    @selected_item = 2
    @order_name.destroy

    respond_to do |format|
      format.html { redirect_to order_names_url, notice: "Order name was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_name
      @order_name = OrderName.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_name_params
      params.require(:order_name).permit(:content, :user_id, :system_name_id)
    end
end
