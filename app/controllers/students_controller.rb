class StudentsController < ResourceProtectedController
  before_action :auth_only_user_adults, only: [:index, :show]
  before_action :set_student, only: [:show, :update, :destroy]
  before_action :auth_only_user_academyc, only: [:create, :update, :destroy]

  def index
    students = Student.where({}).joins(:person).includes(:person).page params[:page]
    data = students.map { |student| StudentSerializer.new(student).serializable_hash[:data][:attributes] }
    render json: data
  end

  def show
    json = StudentSerializer.new(@student).serializable_hash[:data][:attributes]
    render json: json
  end

  def create
    person_data = person_params
    @student = Student.new student_params

    identity_document = person_data && person_data[:identity_document] || nil
    @person = Person.where(identity_document: identity_document).take

    if !@person
      @person = Person.new(person_data)
    end

    if @person.id.nil? && !@person.save
      return show_error @person
    end

    @student.person = @person

    if !@student.save
      return show_error @student
    end

    json = StudentSerializer.new(@student).serializable_hash[:data][:attributes]
    render json: json, status: :created
  end

  def update
    @person = @student.person

    person_data = {
      phone_code: person_params[:phone_code],
      phone_number: person_params[:phone_number],
      address: person_params[:address],
    }

    if !@person.update(person_data)
      return show_error @person
    end

    if !@student.update(student_params)
      return show_error @student
    end

    json = StudentSerializer.new(@student).serializable_hash[:data][:attributes]
    render json: json, status: :accepted
  end

  def destroy
    if !@student.destroy
      return show_error @student
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :last_name, :identity_document, :phone_code, :phone_number, :address)
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:birthday)
  end
end
