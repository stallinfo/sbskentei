class ClassificationNamesController < ApplicationController
  before_action :set_classification_name, only: %i[ show edit update destroy ]

  # GET /classification_names or /classification_names.json
  def index
    @classification_names = ClassificationName.all
  end

  # GET /classification_names/1 or /classification_names/1.json
  def show
  end

  # GET /classification_names/new
  def new
    @classification_name = ClassificationName.new
  end

  # GET /classification_names/1/edit
  def edit
  end

  # POST /classification_names or /classification_names.json
  def create
    @classification_name = ClassificationName.new(classification_name_params)

    respond_to do |format|
      if @classification_name.save
        format.html { redirect_to classification_name_url(@classification_name), notice: "Classification name was successfully created." }
        format.json { render :show, status: :created, location: @classification_name }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @classification_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classification_names/1 or /classification_names/1.json
  def update
    respond_to do |format|
      if @classification_name.update(classification_name_params)
        format.html { redirect_to classification_name_url(@classification_name), notice: "Classification name was successfully updated." }
        format.json { render :show, status: :ok, location: @classification_name }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @classification_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classification_names/1 or /classification_names/1.json
  def destroy
    @classification_name.destroy

    respond_to do |format|
      format.html { redirect_to classification_names_url, notice: "Classification name was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classification_name
      @classification_name = ClassificationName.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classification_name_params
      params.require(:classification_name).permit(:content, :user_id, :order_name_id)
    end
end
