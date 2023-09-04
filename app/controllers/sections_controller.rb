class SectionsController < ResourceProtectedController
  before_action :auth_only_user_academyc
  before_action :set_section, only: [:show, :update, :destroy]

  def index
    sections = Section.page params[:page]
    render sections
  end

  def show
    render json: @section
  end

  def create
    @section = Section.new(section_params)

    if !@section.save
      return show_error @section
    end

    render json: @section, status: :created
  end

  def update
    if !@section.update(section_params)
      return show_error @section
    end

    render json: @section, status: :accepted
  end

  def destroy
    if !@section.destroy
      return show_error @section
    end

    render status: :no_content
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:letter)
  end
end
