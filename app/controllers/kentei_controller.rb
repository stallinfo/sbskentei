class KenteiController < ApplicationController
  def index
    @selected_item = 0
    @kmondais = Kmondai.first
  end

  def siken
    @selected_item = 1
    @qrcode = RQRCode::QRCode.new("test", :size => 4, :level => :h)
  end


end
