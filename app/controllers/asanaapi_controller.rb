class AsanaapiController < ApplicationController

    skip_before_action :verify_authenticity_token
    def ramen01
        apikey = params[:apikey]
        jsonMsg(200, "Welcome to Asana Ramen", apikey)
    end

    def teamlist
        apikey = request.headers["apikey"]
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end

        workspaces = client.workspaces.find_all
        wid = workspaces.elements[0].gid
        teams = client.teams.get_teams_for_organization(workspace_gid: wid, options: {fields: ["gid", "name"]})
        result = {}
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
        apikey = params[:apikey]
        gid = params[:gid]

        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end

        workspaces = client.workspaces.find_all
        wid = workspaces.elements[0].gid
        projects = client.projects.get_projects(team: "1199714224727434")
        result = {}
        results = []
        
        teams.elements.each do |element|
            result = {}
            result["gid"] = element.gid
            result["name"] = element.name
            results.push result
        end
        jsonMsg(200, "チームズ一蘭", results)
    end

    private 
        def jsonMsg(errNum, errMessage, results)
            responseInfo = {status: errNum, developerMessage: errMessage}
            metadata = {responseInfo: responseInfo}
            jsonString = {metadata: metadata, results: results}
            render json: jsonString.to_json
        end
end
