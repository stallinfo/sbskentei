class KmondaisController < ApplicationController
  before_action :set_kmondai, only: %i[ show edit update destroy ]

  # GET /kmondais or /kmondais.json
  def index
    @selected_item = 0
    #@kmondais = Kmondai.all
    @kmondais = Kmondai.paginate(page: params[:page], :per_page => 20)
  end

  # GET /kmondais/1 or /kmondais/1.json
  def show
  end

  # GET /kmondais/new
  def new
    @selected_item = 0
    @kmondai = Kmondai.new
  end

  # GET /kmondais/1/edit
  def edit
    @selected_item = 0
  end

  # POST /kmondais or /kmondais.json
  def create
    @kmondai = Kmondai.new(kmondai_params)

    respond_to do |format|
      if @kmondai.save
        format.html { redirect_to @kmondai, notice: "Kmondai was successfully created." }
        format.json { render :show, status: :created, location: @kmondai }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kmondai.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kmondais/1 or /kmondais/1.json
  def update
    respond_to do |format|
      if @kmondai.update(kmondai_params)
        format.html { redirect_to @kmondai, notice: "Kmondai was successfully updated." }
        format.json { render :show, status: :ok, location: @kmondai }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kmondai.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kmondais/1 or /kmondais/1.json
  def destroy
    @kmondai.destroy
    respond_to do |format|
      format.html { redirect_to kmondais_url, notice: "Kmondai was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def newexcel
    @selected_item = 1
  end

  def kentei_excel
    file_xls=excelupload_params['filename']
    workbook=RubyXL::Parser.parse_buffer(file_xls.read)
    worksheet=workbook[0]
    (2..worksheet.count-1).each do |row|
      raw_question = worksheet[row][1]
      if raw_question!=nil
        raw_question = worksheet[row][1].value
        level=getlevel(worksheet[row][4].value)
        ans=getans(worksheet[row][2].value)
        
        if Kmondai.where("oriquestion=?",raw_question).first==nil
          
          kmondai = Kmondai.where("number=?",worksheet[row][0].value.to_i).first
          question, answers=q_and_a(raw_question)
          if kmondai==nil
            kmondai=Kmondai.create(question: question, 
                                   oriquestion: raw_question,
                                   explanation: worksheet[row][3].value, 
                                   number: worksheet[row][0].value.to_i, 
                                   system: worksheet[row][5].value,
                                   order: worksheet[row][6].value,
                                   suborder: worksheet[row][7].value,
                                   answer: ans,
                                   level: level,
                                   demasu: false)
          else
            kmondai.update_attributes(question: question, 
                                   oriquestion: raw_question,
                                   explanation: worksheet[row][3].value, 
                                   number: worksheet[row][0].value.to_i, 
                                   system: worksheet[row][5].value,
                                   order: worksheet[row][6].value,
                                   suborder: worksheet[row][7].value,
                                   answer: ans,
                                   level: level)
          end
          answers.each do |k,v|
            kchoice= Kchoice.where("kmondai_id=? AND number=?", kmondai.id, k ).first
            if kchoice==nil
              Kchoice.delay.create(number: k, sentence: v, kmondai_id: kmondai.id)
            else
              kchoice.update_attributes(sentence: v, kmondai_id: kmondai.id)
            end
          end
        end
      end
    end
    redirect_to kmondais_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kmondai
      @kmondai = Kmondai.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kmondai_params
      params.require(:kmondai).permit(:number, :question, :level, :answer, :system, :order, :suborder, :explanation)
    end

    def excelupload_params
      params.require(:excelupload).permit(:filename)
    end

    def q_and_a(r_question)
      question=""
      answers={}
      inquestion=true
      split_question=r_question.split("\n")
      (0..split_question.count-1).each do |line|
        if split_question[line][0]!=nil
          if split_question[line][0]=="①"
            answers[1]=split_question[line][1..split_question[line].length-1]
            inquestion=false
          elsif split_question[line][0]=="②"
            answers[2]=split_question[line][1..split_question[line].length-1]
            inquestion=false
          elsif split_question[line][0]=="③"
            answers[3]=split_question[line][1..split_question[line].length-1]
            inquestion=false
          elsif split_question[line][0]=="④"
            answers[4]=split_question[line][1..split_question[line].length-1]
            inquestion=false
          elsif split_question[line][0]=="⑤"
            answers[5]=split_question[line][1..split_question[line].length-1]
            inquestion=false
          elsif split_question[line][0]=="⑥"
            answers[6]=split_question[line][1..split_question[line].length-1]
            inquestion=false
          elsif split_question[line][0]=="⑦"
            answers[7]=split_question[line][1..split_question[line].length-1]
            inquestion=false
          end
        end
      
        if inquestion==true
          question+=split_question[line]
        end
      end
      return question, answers
    end

    def getans(ans)
      correct_ans=""
      (0..ans.length-1).each do |i|
        if ans[i]=="①"
          correct_ans+="1,"
        elsif ans[i]=="②"
          correct_ans+="2,"
        elsif ans[i]=="③"
          correct_ans+="3,"
        elsif ans[i]=="④"
          correct_ans+="4,"
        elsif ans[i]=="⑤"
          correct_ans+="5,"
        elsif ans[i]=="⑥"
          correct_ans+="6,"
        elsif ans[i]=="⑦"
          correct_ans+="7,"
        end
      end
      correct_ans=correct_ans[0..correct_ans.length-2]
    end

    def getlevel(level) #levelabamba
      intlevel=0
      (0..level.length-1).each do |i|
        if level[i]=="★"
          intlevel+=1
        end
      end
      return intlevel
    end

end
