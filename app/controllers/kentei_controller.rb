class KenteiController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @selected_item = 0
    @kmondais = Kmondai.first
    @kenteidummy=true
    if params[:selected_date]== nil
      @selected_date=Time.zone.now.to_date
    else 
      @selected_date=Date.parse(params[:selected_date])
    end
    if Kmondai.count>0
      dailyexcercise = Dailyexcercise.where("DATE(daily)='#{@selected_date.to_date}'").first
      @answered=Kenteikaitou.where("user_id=? AND DATE(datetest)='#{@selected_date.to_date}'",current_user.id).first
      if @answered!=nil
        @decided=false
      else
        if dailyexcercise==nil
          #mondai selected randomly
          dailyexcercise= randomkentei(@selected_date)
          @decided=true
          @kentei=Kmondai.find(dailyexcercise.kmondai_id)
          @kchoice=@kentei.kchoices[0]
        else
          @kentei=Kmondai.find(dailyexcercise.kmondai_id)
          @kchoice=@kentei.kchoices[0]
        end
        @decided=true
      end
    end
  end
  
  def dailyanswer
    @decided=false
    @selected_item=0
    kmondai= Kmondai.find(answerquestion_params['kmondai_id'])
    if params[:answerquestion][:c_date]==""
      @selected_date=Time.zone.now.to_date
    else
      @selected_date = Date.parse(params[:answerquestion][:c_date])
    end

    cbchoice=[]
    if answerquestion_params['cbchoice']!=nil
      cbchoice=check_box_bug(answerquestion_params['cbchoice'])
      answerstring =""
      answercount =0
      cbchoice.each do |k,v|
        answercount+=1
        if v==1
          answerstring+=answercount.to_s+","
        end
      end
      answerstring=answerstring[0..answerstring.length-2]
      if answerstring!=""
        saveanswer(@selected_date,answerstring,kmondai)
      else
        @angry=true
      end
    else
      if answerquestion_params['choices']=="choice1"; answerstring='1' end
      if answerquestion_params['choices']=="choice2"; answerstring='2' end
      if answerquestion_params['choices']=="choice3"; answerstring='3' end
      if answerquestion_params['choices']=="choice4"; answerstring='4' end
      if answerquestion_params['choices']=="choice5"; answerstring='5' end
      if answerquestion_params['choices']=="choice6"; answerstring='6' end
      if answerquestion_params['choices']=="choice7"; answerstring='7' end
      if answerstring!=nil
        saveanswer(@selected_date,answerstring,kmondai)
      else
        @angry=true
      end
    end
    @answered=Kenteikaitou.where("user_id=? AND DATE(datetest)='#{@selected_date.to_date}'",current_user.id).first
    if @answered!=nil
      @decided=false
    else
      dailyexcercise = Dailyexcercise.where("DATE(daily)='#{@selected_date.to_date}'").first
      if dailyexcercise==nil
        #mondai selected randomly
        dailyexcercise= randomkentei(@selected_date)
      end
      @decided=true
      @kentei=Kmondai.find(dailyexcercise.kmondai_id)
      @kchoice=@kentei.kchoices[0]
    end
    @kenteidummy=true
    render 'index'
  end
  
  def siken
    @selected_item = 1
  
    @qrcode = RQRCode::QRCode.new("test", :size => 4, :level => :h)
  end

  def sikenindex
    @disables=['','','']
    @selected_item=3
  end

  def shinkishiken
    @selected_item=3
    @disables=['','','']
    @naiyo=0
    @error_messages=""
  end

  def createtest
    @disables=['disabled','','disabled']
    @naiyo=1
    @selected_item=3
    @error_messages=""
    if fukusu_params['testname']=="" || fukusu_params['testname']==nil
      @naiyo=1
      @error_messages="テスト名前を書いてください。"
    elsif fukusu_params['numofexams'].to_i<=0
      @naiyo=1
      @error_messages="問題数を決めてください。"
    else
      @fukusu=Fukusu.create(user_id: current_user.id, fname: fukusu_params['testname'], numofexam: fukusu_params['numofexams'].to_i)
      @kenteis=Kmondai.all.order("number")
    end
    render 'shinkishiken'
  end

  def choosemondai
  end

  def shikenkanri
    @selected_item=3
    @disables=['','','']
  end

  def kentei_changedate
    #datechanged = Date.parse(changedate_params['selected_date'])
    #redirect_to kentei_path(:selected_date => datechanged)

    @selected_item=0

    if params[:changedate][:selected_date]==""
      @selected_date=Time.zone.now.to_date
    else
      @selected_date = Date.parse(changedate_params['selected_date'])
      #@selected_date = Date.strptime(params[:changedate][:selected_date], '%m/%d/%Y')
    end

    if @selected_date <= (Time.zone.now).to_date
      @kenteidummy=true
      
      @answered=Kenteikaitou.where("user_id=? AND DATE(datetest)='#{@selected_date.to_date}'",current_user.id).first
      if @answered!=nil
        @decided=false
      else
        dailyexcercise = Dailyexcercise.where("DATE(daily)='#{@selected_date.to_date}'").first
        if dailyexcercise==nil
          #mondai selected randomly
          dailyexcercise= randomkentei(@selected_date)
        end
        @decided=true
        @kentei=Kmondai.find(dailyexcercise.kmondai_id)
        @kchoice=@kentei.kchoices[0]
      end
    else
      @kenteidummy=false
    end
    render 'index'
  end

  def refactor
   
  end

  private
  def changedate_params
    params.require(:changedate).permit(:selected_date)
  end

  def answerquestion_params
    params.require(:answerquestion).permit(:c_date, :kmondai_id, :choices, :cbchoice=>[])
  end

  def fukusu_params
    params.require(:fukusu).permit(:testname, :numofexams)
  end

  def randomkentei(selected_date)
    # random
    randomnumber=Random.rand(1..Kmondai.count)
    #selected_date = Date.parse(decideexercise_params['decideddate'])
    #selected_date = Time.zone.now.to_date
    
    # check new excercise
    kentei = Kmondai.where(demasu: false).first
    if kentei==nil
      kentei = Kmondai.where("number=?", randomnumber).first
      kentei.update(demasu: true)
    end
    kentei.update(demasu: true)
    Dailyexcercise.create!(kmondai_id: kentei.id,
                           user_id: current_user.id, 
                           daily: selected_date+9.hours)
    kmondai = Dailyexcercise.last
  end

  def saveanswer(c_date, answer, kmondai)
    if kmondai.answer==answer 
      #if !kenteikaitou=Kenteikaitou.where("user_id=? AND kmondai_id=? AND DATE(datetest)=='#{c_date.to_date+9.hours}'",current_user.id, kmondai.id).first
        Kenteikaitou.create(user_id: current_user.id, kmondai_id: kmondai.id, correct: true, datetest: c_date.to_date+9.hours, answer: answer)
      #else
      #  kenteikaitou.update_attributes(correct: true)
      #end
    else
      #if !kenteikaitou=Kenteikaitou.where("user_id=? AND kmondai_id=? AND DATE(datetest)=='#{c_date.to_date+9.hours}'",current_user.id, kmondai.id).first
        Kenteikaitou.create(user_id: current_user.id, kmondai_id: kmondai.id, correct: false, datetest: c_date.to_date+9.hours, answer: answer)
      #else
      #  kenteikaitou.update_attributes(correct: false)
      #end
    end
  end

  def check_box_bug(param_checkbox)
    count_array=0
    result={}
    (0..param_checkbox.count-1).each do |i|
      if param_checkbox[i]=='1'
        count_array -= 1
        result[count_array]=1
        count_array += 1
      else
        result[count_array]=0
        count_array += 1
      end
    end
    return result
  end


end
