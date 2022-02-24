class KenteiapisController < ApplicationController
    skip_before_action :verify_authenticity_token

    def randomexam
        userid = params[:id].to_i
        usertoken = params[:token]
        #user = User.find_by(token: usertoken)
        examnumber = Random.rand(1..Kmondai.count)
        #if  user && user.id == userid
        #    result = "OK"
        #else
        
        #end
        jsonMsg(200, "randomnumber", examnumber )
    end
    private 
    def jsonMsg(errNum, errMessage, results)
        responseInfo = {status: errNum, developerMessage: errMessage}
        metadata = {responseInfo: responseInfo}
        jsonString = {metadata: metadata, results: results}
        render json: jsonString.to_json
    end
end
