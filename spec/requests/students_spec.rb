require "rails_helper"
require_relative "../support/devise"

RSpec.describe "Students", type: :request do
  let(:birthday) { (Date.current - 365 * 12) }
  let(:phone_code) { Faker::Number.number(digits: 3) }
  let(:phone_number) { Faker::Number.number(digits: 10) }
  let(:identity_document) { Faker::Number.number(digits: 10) }

  let(:person) {
    {
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_code: phone_code,
      phone_number: phone_number,
      identity_document: identity_document,
    }
  }

  let(:student) { Student.create(birthday: birthday, person: Person.create(person)) }

  context "POST /" do
    describe "session student and representative" do
      it "create student from a user student" do
        data = FactoryBot.create(:user_role_student)
        current_user = User.find(data[:user_id])
        sign_in current_user

        post students_url, params: { person: person, student: { birthday: birthday } }
        expect(response).to have_http_status(403)
      end
    end

    describe "session manager" do
      before(:each) do
        data = FactoryBot.create(:user_role_manager)
        current_user = User.find(data[:user_id])
        sign_in current_user
      end

      it "returns http unprocessable_entity when the birthday is null" do
        post students_url, params: { person: person, student: { birthday: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns http unprocessable_entity when the birthday isn't valid" do
        post students_url, params: { person: person, student: { birthday: Date.today } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns http created" do
        post students_url, params: { person: person, student: { birthday: birthday } }
        expect(response).to have_http_status(:created)
      end

      it "returns http created when the person exist before" do
        p = Person.create(person)

        post students_url, params: { person: person, student: { birthday: birthday } }
        response_json = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(p.id).to eq(response_json["person"]["id"])
      end
    end
  end

  context "PUT /:id" do
    describe "session student and representative" do
      it "create student from a user student" do
        data = FactoryBot.create(:user_role_student)
        current_user = User.find(data[:user_id])
        sign_in current_user

        attributes = person.clone
        attributes[:address] = Faker::Address.full_address

        put student_path(student), params: { person: attributes, student: { birthday: birthday + 10 } }
        expect(response).to have_http_status(403)
      end
    end

    describe "session manager" do
      before(:each) do
        data = FactoryBot.create(:user_role_manager)
        current_user = User.find(data[:user_id])
        sign_in current_user
      end

      it "returns http unprocessable_entity when the birthday is null" do
        put student_path(student), params: { person: person, student: { birthday: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns http unprocessable_entity when the birthday isn't valid" do
        put student_path(student), params: { person: person, student: { birthday: Date.today } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns http accepted" do
        attributes = person.clone
        attributes[:address] = Faker::Address.full_address

        person_id = student.person_id
        put student_path(student), params: { person: attributes, student: { birthday: birthday + 10 } }

        response_json = JSON.parse(response.body)
        expect(response).to have_http_status(:accepted)
        expect(person_id).to eq(response_json["person"]["id"])
        expect(attributes[:address]).to eq(response_json["person"]["address"])
      end
    end
  end

  context "DELETE /:id" do
    describe "session student and representative" do
      it "create student from a user student" do
        data = FactoryBot.create(:user_role_student)
        current_user = User.find(data[:user_id])
        sign_in current_user

        delete student_path(student)
        expect(response).to have_http_status(403)
      end
    end

    describe "session manager" do
      before(:each) do
        data = FactoryBot.create(:user_role_manager)
        current_user = User.find(data[:user_id])
        sign_in current_user
      end

      it "returns http success" do
        delete student_path(student)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
