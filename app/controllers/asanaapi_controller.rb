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
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        tasks = client.tasks.get_tasks(project: "1201517440355932")

    end

    def pv_user
        apikey = params[:apikey]
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        result = client.users.get_user(user_gid: 'me', options: {fields: ["gid", "name"]})
        jsonMsg(200, "User me", result.gid)
    end

    def pv_task
        apikey = params[:apikey]
        taskid = params[:taskid]
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        result = client.tasks.get_task(task_gid: taskid)
        #result = client.tasks.get_task(task_gid: taskid, options: {fields: ["gid", "name", "memberships"]})
        jsonMsg(200, "Task", result)
    end
    
    def pv_subtasks
        apikey = params[:apikey]
        taskid = params[:taskid]
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        results = client.tasks.get_subtasks_for_task(task_gid: taskid)
        jsonMsg(200, "subtasks", results)
    end

    def pv_section
        apikey = params[:apikey]
        sectionid = params[:sectionid]
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        result = client.tasks.get_task(section_gid: sectionid)
        #result = client.tasks.get_task(task_gid: taskid, options: {fields: ["gid", "name", "memberships"]})
        jsonMsg(200, "Task", result)
    end
   

    def pv_tasks
        apikey = params[:apikey]
        projectid = params[:projectid]
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        results = client.tasks.get_tasks(project: projectid, options: {fields: ["gid", "name"]})
        jsonMsg(200, "tasks", results)
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
        apikey = request.headers["apikey"]
        if !apikey
            apikey = params[:apikey]
        end 
        taskid = params[:taskid]
        hour = params[:hour].to_i
        datestring = params[:date]
        
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        user = client.users.get_user(user_gid: 'me', options: {fields: ["gid", "name", "resource_type"]})
        
        result = client.tasks.create_subtask_for_task(task_gid: taskid, name: datestring, custom_fields: {"1201530869444176": hour})
        jsonMsg(200, "create task", result)
    end

    private 
        def jsonMsg(errNum, errMessage, results)
            responseInfo = {status: errNum, developerMessage: errMessage}
            metadata = {responseInfo: responseInfo}
            jsonString = {metadata: metadata, results: results}
            render json: jsonString.to_json
        end
end
