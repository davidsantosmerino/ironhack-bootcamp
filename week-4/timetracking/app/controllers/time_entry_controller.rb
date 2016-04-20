class TimeEntryController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @entries = @project.time_entries
    render "index"
  end

  def new
    @my_project = Project.find(params[:project_id])
    @my_entry = @my_project.time_entries.new
    render "new"
  end

  def create
    @my_project = Project.find(params[:project_id])
    @my_entry = @my_project.time_entries.new(
      :hours => params[:time_entry][:hours],
      :minutes => params[:time_entry][:minutes],
      :comments => params[:time_entry][:comments]
    )

   @my_entry.save
   redirect_to "/projects/#{@my_project.id}/time_entries"
  end
end
