class KenteiController < ApplicationController
  def index
    @selected_item = 0
    @kmondais = Kmondai.first
  end

  def siken
    @selected_item = 1
  end


end
