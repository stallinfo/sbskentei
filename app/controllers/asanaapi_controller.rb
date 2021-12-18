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
        #result = client.tasks.get_task(task_gid: taskid)
        result = client.tasks.get_task(task_gid: taskid, options: {fields: ["gid", "name", "assignee"]})
        jsonMsg(200, "Task", result.assignee["gid"])
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

    def taskinsection
    
        apikey = request.headers["apikey"]
        if !apikey
            apikey = params[:apikey]
        end 
        #sectionid = params[:sectionid]
        sectionid = "1201517440355938"
        #datestring = '2021-12-18'
        jsonraw = request.raw_post
        data_parsed = JSON.parse(jsonraw)
        datestring = data_parsed["date"]

        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        user = client.users.get_user(user_gid: 'me', options: {fields: ["gid", "name", "resource_type"]})

        #result = client.tasks.get_tasks_for_section(section_gid: sectionid)
        result = client.tasks.get_tasks_for_section(section_gid: sectionid, options: {fields: ["gid", "name", "assignee", "completed", "due_on"]})
        tasks = []
        date = Date.parse(datestring)
        result.elements.each do |element|
            if element.due_on
                due_on = Date.parse(element.due_on)
            end
            if element.assignee && element.assignee["gid"] == user.gid && !element.completed && element.due_on && date == due_on
                task = {}
                task["gid"] = element.gid
                task["name"] = element.name
                task["completed"] = element.completed
                task["due_on"] = element.due_on
                tasks.push task
            end
        end
        jsonMsg(200, "Tasks in section", tasks)
    end
   
    def pv_section
        apikey = params[:apikey]
        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        projectid = params[:projectid]
        result = client.sections.get_sections_for_project(project_gid: projectid)
        jsonMsg(200, "Sections in project", result)
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

    def create_task_01 #create subtask for hourly work
        apikey = request.headers["apikey"]
        if !apikey
            apikey = params[:apikey]
        end 
        jsonraw = request.raw_post

        #taskid = params[:taskid]
        #hour = params[:hour]
        #datestring = params[datestring].to_s

        data_parsed = JSON.parse(jsonraw)
        taskid = data_parsed["taskid"]
        hour = data_parsed["hour"]
        datestring = data_parsed["date"]

        client = Asana::Client.new do |c|
            c.authentication :access_token, apikey
        end
        user = client.users.get_user(user_gid: 'me', options: {fields: ["gid", "name", "resource_type"]})
        
        result = client.tasks.create_subtask_for_task(task_gid: taskid, name: datestring, due_on: datestring, custom_fields: {"1201530869444176": hour}, assignee: user.gid)
        jsonMsg(200, "create task with ramen", result )
    end

   

    private 
        def jsonMsg(errNum, errMessage, results)
            responseInfo = {status: errNum, developerMessage: errMessage}
            metadata = {responseInfo: responseInfo}
            jsonString = {metadata: metadata, results: results}
            render json: jsonString.to_json
        end
end
