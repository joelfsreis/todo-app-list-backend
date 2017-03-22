class TasksController < ApplicationController

  def index
    render json: Task.all
  end

  def show
    render json: Task.find(params[:id])
  end

  def destroy
    Task.find(params[:id]).destroy
    head :no_content
  end

  def create
    # @task = Task.create!(params.require(:task).permit(:text, :completed))
    @task = Task.create!(params.permit(:text, :completed))

    render json: @task
  end

  def update
    @task = Task.find params[:id]
    @task.update_attributes(params.permit(:text, :completed))

    render json: @task
  end

end
