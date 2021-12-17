class AsanasController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index #get
    @selected_item = 0
 
    client = Asana::Client.new do |c|
      c.authentication :access_token, current_user.asanaapi
    end
    @workspace = client.workspaces.find_all
    wid = @workspace.elements[0].gid
    #@teams = client.teams.get_teams_for_organization(workspace_gid: wid)
    #@projects = client.projects.get_projects(team: "1199714224727434")
    
    @tasks = client.tasks.get_tasks(project: "1199714224727455",options: {fields: ["gid", "created_at"]})# .lazy.drop(270).take(15).to_a
    #@projects = client.projects.get_projects(workspace: wid, options: {fields: ["gid", "name"]}).lazy.drop(1).take(19)
    1200762922760993
    @task = client.tasks.get_task(task_gid: "1200762922760993")
  end

  def kpi #get
    @selected_item = 1
  end

  def apitest
    param01 = params[:title]
    jsonMsg(500,"Welcome to Asana Ramen", param01)
  end

  private 
  def jsonMsg(errNum, errMessage, results)
      responseInfo = {status: errNum, developerMessage: errMessage}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: results}
      render json: jsonString.to_json
  end
end
