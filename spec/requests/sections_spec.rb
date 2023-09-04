require "rails_helper"

RSpec.describe "Sections", type: :request do
  let(:section) { FactoryBot.create(:section) }

  context "Session User Student" do
    before(:each) do
      data = FactoryBot.create(:user_role_student)
      current_user = User.find(data[:user_id])
      sign_in current_user
    end

    it "GET /" do
      get sections_url
      expect(response).to have_http_status(:forbidden)
    end

    it "POST /" do
      post sections_url
      expect(response).to have_http_status(:forbidden)
    end

    it "PUT /:id" do
      put section_path(section)
      expect(response).to have_http_status(:forbidden)
    end

    it "DELETE /:id" do
      delete section_path(section)
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
      get sections_url
      expect(response).to have_http_status(:forbidden)
    end

    it "POST /" do
      post sections_url
      expect(response).to have_http_status(:forbidden)
    end

    it "PUT /:id" do
      put section_path(section)
      expect(response).to have_http_status(:forbidden)
    end

    it "DELETE /:id" do
      delete section_path(section)
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
      get sections_url
      expect(response).to have_http_status(:success)
    end

    describe "POST /" do
      it "send section without letter" do
        post sections_url, params: { section: { letter: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "send section with greater than one letter" do
        post sections_url, params: { section: { letter: "section-unique-2" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success created" do
        letter = "a"
        post sections_url, params: { section: { letter: letter } }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(body["letter"]).to eq(letter.upcase)
      end
    end

    describe "PUT /:id" do
      it "send subject without letter" do
        put section_path(section), params: { section: { letter: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "send section with greater than one letter" do
        put section_path(section), params: { section: { letter: "letter" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success updated" do
        letter = "b"
        put section_path(section), params: { section: { letter: letter } }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:accepted)
        expect(body["letter"]).to eq(letter.upcase)
      end
    end

    it "DELETE /:id" do
      delete section_path(section)
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
      get sections_url
      expect(response).to have_http_status(:success)
    end

    describe "POST /" do
      it "send section without letter" do
        post sections_url, params: { section: { letter: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "send section with greater than one letter" do
        post sections_url, params: { section: { letter: "section-unique-2" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success created" do
        letter = "a"
        post sections_url, params: { section: { letter: letter } }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(body["letter"]).to eq(letter.upcase)
      end
    end

    describe "PUT /:id" do
      it "send subject without letter" do
        put section_path(section), params: { section: { letter: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "send section with greater than one letter" do
        put section_path(section), params: { section: { letter: "letter" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "success updated" do
        letter = "b"
        put section_path(section), params: { section: { letter: letter } }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:accepted)
        expect(body["letter"]).to eq(letter.upcase)
      end
    end

    it "DELETE /:id" do
      delete section_path(section)
      expect(response).to have_http_status(:no_content)
    end
  end
end
