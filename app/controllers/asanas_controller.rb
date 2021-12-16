class AsanasController < ApplicationController
  def index #get
    @selected_item = 0
 
    client = Asana::Client.new do |c|
      c.authentication :access_token, current_user.asanaapi
    end
    @workspace = client.workspaces.find_all
    wid = @workspace.elements[0].gid
    #@teams = client.teams.get_teams_for_organization(workspace_gid: wid)
    #@projects = client.projects.get_projects(team: "1199714224727434")

    @tasks = client.tasks.get_tasks(project: "1199714224727455").lazy.drop(270).take(15)
    #@projects = client.projects.get_projects(workspace: wid, options: {fields: ["gid", "name"]}).lazy.take(19)
  end

  def kpi #get
    @selected_item = 1
  end
end
