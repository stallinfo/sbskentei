class AsanaapiController < ApplicationController

    skip_before_action :verify_authenticity_token
    def ramen01
        apikey = params[:apikey]
        jsonMsg(200, "Welcome to Asana Ramen", apikey)
    end

    def teamlist
        apikey = request.headers["apikey"]
        if !apikey
            apikey = params[:apikey] 
        end
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end

        teams = client.teams.get_teams_for_organization(workspace_gid: "505269877956434", options: {fields: ["gid", "name"]})
       
        results = []
        
        teams.elements.each do |element|
            result = {}
            result["gid"] = element.gid
            result["name"] = element.name
            results.push result
        end
        jsonMsg(200, "チームズ一蘭", results)
    end

    def projectlist
        apikey = request.headers["apikey"]
        if !apikey 
            apikey = params[:apikey]
        end
        #teamid = request.headers["teamid"]
        #apikey = params[:apikey]
        teamid = params[:teamid]

        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end

        projects = client.projects.get_projects(team: teamid, options: {fields: ["gid", "name"]})
       
        results = []
        
        projects.elements.each do |element|
            result = {}
            result["gid"] = element.gid
            result["name"] = element.name
            results.push result
        end
        jsonMsg(200, "プロジェクト一蘭", results)
    end

    def pv_tasklist
        apikey = params[:apikey]
        projectid = params[:projectid]
    end

    def project
        apikey = request.headers["apikey"]
        if !apikey
            apikey = params[:apikey]
        end 
        projectid = params[:projectid]

        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        ps = client.projects.get_project(project_gid: '1201100703207559')
        jsonMsg(200, "進捗", ps)

    end

    def create_task_01

    end

    private 
        def jsonMsg(errNum, errMessage, results)
            responseInfo = {status: errNum, developerMessage: errMessage}
            metadata = {responseInfo: responseInfo}
            jsonString = {metadata: metadata, results: results}
            render json: jsonString.to_json
        end
end
