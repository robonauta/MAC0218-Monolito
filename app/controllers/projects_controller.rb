class ProjectsController < ApplicationController
#    protect_from_forgery unless: -> { request.format.json? }
    def index
        @projects = Project.all
        render 'index'
    end
  
    def show
      @project = Project.find(params[:id])
      @show_edit = false;
      if current_user
        if (@project.user_id == current_user.id || current_user.rank == "admin") 
          @show_edit = true;
        end
      end
    end
  
    def new
      if current_user
      else
        redirect_to '/login'
      end
    end
  
    def create
      @project = Project.new
#      @project.name = project_params[:project][:name]
      @project.user_id = current_user.id
      @project.images.build(project_params[:project][:files])
#      for file in project_params[:project][:files] do 
#
#        puts 'testee'
#      end
      
      if(@project.save)
        redirect_to '/'
      else
        render 'new'
      end
      
    end
  
    def edit
      @project = Project.find(params[:id])
      @project.user_id = current_user.id
    end
  
    def update
      @project = Project.find(params[:id])
      
      if(@project.update(project_params))
        redirect_to @project
      else
        render 'edit'
      end
    end
  
    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to projects_path
    end
  
    def dashboard
      @projects = Project.all
#      render plain: params[:post].inspect
      render 'dashboard'
    end

    private def project_params
      params.require(:project).permit(:name, :files)
    end
      
end