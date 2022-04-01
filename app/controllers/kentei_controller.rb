class KenteiController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @selected_item = 0
    @kmondais = Kmondai.first
    if params[:selected_date]== nil
      @selected_date=Time.zone.now.to_date
    else 
      @selected_date=Date.parse(params[:selected_date])
    end
  end

  def siken
    @selected_item = 1
    @qrcode = RQRCode::QRCode.new("test", :size => 4, :level => :h)
  end

  def kentei_changedate
    datechanged = Date.parse(changedate_params['selected_date'])
    redirect_to kentei_path(:selected_date => datechanged)
  end

  def refactor
   
  end

  private
  def changedate_params
    params.require(:changedate).permit(:selected_date)
  end


end
