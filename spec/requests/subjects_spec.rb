require "rails_helper"

RSpec.describe "Subjects", type: :request do
  let(:subject) { FactoryBot.create(:subject) }

  context "Session User Student" do
    before(:each) do
      data = FactoryBot.create(:user_role_student)
      current_user = User.find(data[:user_id])
      sign_in current_user
    end

    it "GET /" do
      get subjects_url
      expect(response).to have_http_status(:forbidden)
    end

    it "POST /" do
      post subjects_url
      expect(response).to have_http_status(:forbidden)
    end

    it "PUT /:id" do
      put subject_path(subject)
      expect(response).to have_http_status(:forbidden)
    end

    it "DELETE /:id" do
      delete subject_path(subject)
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "Session User Representative" do
    before(:each) do
      data = FactoryBot.create(:user_role_representative)
      current_user = User.find(data[:user_id])
      sign_in current_user
    end

    it "GET /" do
      get subjects_url
      expect(response).to have_http_status(:forbidden)
    end

    it "POST /" do
      post subjects_url
      expect(response).to have_http_status(:forbidden)
    end

    it "PUT /:id" do
      put subject_path(subject)
      expect(response).to have_http_status(:forbidden)
    end

    it "DELETE /:id" do
      delete subject_path(subject)
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "Session User Profesor" do
    before(:each) do
      data = FactoryBot.create(:user_role_profesor)
      current_user = User.find(data[:user_id])
      sign_in current_user
    end

    it "GET /" do
      get subjects_url
      expect(response).to have_http_status(:success)
    end

    describe "POST /" do
      it "send subject without name" do
        post subjects_url, params: { subject: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success created" do
        post subjects_url, params: { subject: { name: "subject-unique-2" } }
        expect(response).to have_http_status(:created)
      end
    end

    describe "PUT /:id" do
      it "send subject without name" do
        put subject_path(subject), params: { subject: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success updated" do
        put subject_path(subject), params: { subject: { name: "subject-unique-3" } }
        expect(response).to have_http_status(:accepted)
      end
    end

    it "DELETE /:id" do
      delete subject_path(subject)
      expect(response).to have_http_status(:no_content)
    end
  end

  context "Session User Manager" do
    before(:each) do
      data = FactoryBot.create(:user_role_manager)
      current_user = User.find(data[:user_id])
      sign_in current_user
    end

    it "GET /" do
      get subjects_url
      expect(response).to have_http_status(:success)
    end

    describe "POST /" do
      it "send subject without name" do
        post subjects_url, params: { subject: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success created" do
        post subjects_url, params: { subject: { name: "subject-unique-2" } }
        expect(response).to have_http_status(:created)
      end
    end

    describe "PUT /:id" do
      it "send subject without name" do
        put subject_path(subject), params: { subject: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success updated" do
        put subject_path(subject), params: { subject: { name: "subject-unique-3" } }
        expect(response).to have_http_status(:accepted)
      end
    end

    it "DELETE /:id" do
      delete subject_path(subject)
      expect(response).to have_http_status(:no_content)
    end
  end
end
