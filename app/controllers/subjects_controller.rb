class SubjectsController < ResourceProtectedController
  before_action :auth_only_user_academyc
  before_action :set_subject, only: [:show, :update, :destroy]

  def index
    subjects = Subject.page params[:page]
    render json: subjects
  end

  def show
    render json: @subject
  end

  def create
    @subject = Subject.new(subject_params)

    if !@subject.save
      return show_error @subject
    end

    render json: @subject, status: :created
  end

  def update
    if !@subject.update(subject_params)
      return show_error @subject
    end

    render json: @subject, status: :accepted
  end

  def destroy
    if !@subject.destroy
      return show_error @subject
    end

    render status: :no_content
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subject_params
    params.require(:subject).permit(:name)
  end
end
