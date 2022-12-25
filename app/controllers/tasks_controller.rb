class TasksController < ApplicationController
  def index
    if params[:sort_deadline_on]
      @tasks = Task.order(deadline_on: :ASC).page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.order(priority: :DESC).page(params[:page])
    elsif params[:search]
      if params[:search][:title].present? and params[:search][:status].present?
        @tasks = Task.where("title LIKE ?", "%#{params[:search][:title]}%").where(status: params[:search][:status]).page(params[:page])
      elsif params[:search][:title].present?
        @tasks = Task.where("title LIKE ?", "%#{params[:search][:title]}%").page(params[:page])
      elsif params[:search][:status].present?
        @tasks = Task.where(status: params[:search][:status]).page(params[:page])
      end
    else
      @tasks = Task.order(created_at: :DESC).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('flash.created')
    else
      render :new
    end

  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('flash.updated')
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: t('flash.destroyed')
  end

  private
    def task_params
      params.require(:task).permit(:title, :content, :deadline_on, :priority, :status)
    end
end