require 'rails_helper'

RSpec.describe Api::SandwichesController, type: :controller do
  # these let! are evaluated before each test
  #
  let!(:blt_sandwich)  { Sandwich.create!(name: "BLT", bread_type: "rye") }
  let!(:tuna_sandwich) { Sandwich.create!(name: "Tuna", bread_type: "rye") }

  # these let are lazily evaluated
  #
  let(:invalid_id) { 999999 }
  let(:sandwich) {
    sandwich = {}
    sandwich[:name] = new_name
    sandwich
  }

  # GET index
  #
  describe "#index" do
    before { get :index, format: :json }

    it_behaves_like "an success"

    it "render all sandwiches" do
      expect(response.body).to include blt_sandwich.name
      expect(response.body).to include tuna_sandwich.name
    end
  end

  # GET show
  #
  describe "#show" do
    context "with an existing id" do
      before { get :show, id: blt_sandwich.id, format: :json }

      it_behaves_like "an success"

      it "render the sandwich" do
        expect(response.body).to include blt_sandwich.name
        expect(response.body).to include blt_sandwich.bread_type
      end
    end
    context "with a non-existing id" do
      before { get :show, id: invalid_id, format: :json }

      it_behaves_like "an error handler"
    end
  end

  # POST create
  #
  describe "#create" do
    context "with valid data" do
      let(:new_name) { "bacon" }
      before { post :create, sandwich: sandwich, format: :json }

      it "render json with code 201" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "201"
      end

      it "render the sandwich" do
        expect(response.body).to include new_name
      end
    end

    context "with invalid data" do
      let(:new_name) { "ab" }
      before { post :create, sandwich: sandwich, format: :json }

      it "render json with code 422" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "422"
      end

      it "render an error message" do
        expect(response.body).to include "Name is too short"
      end
    end
  end
  # PUT / PATCH update
 #
  describe "#update" do
    context "with an existing id and valid data" do
      let(:new_name) { "bacon" }
      before { put :update, id: 1, sandwich: sandwich, format: :json }

      it_behaves_like "an success"

      it "render the sandwich" do
        expect(response.body).to include new_name
        expect(response.body).to include blt_sandwich.bread_type
      end
    end

    context "with an existing id but invalid data" do
      let(:new_name) { "1" }
      before { put :update, id: 1, sandwich: sandwich, format: :json }

      it "render json with code 422" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "422"
      end

      it "render an error message" do
        expect(response.body).to include "Name is too short"
      end
    end

    context "with a non-existing id" do
      before { put :update, id: invalid_id, name: "BACON", format: :json }

      it_behaves_like "an error handler"
    end
  end

  # DELETE destroy
  #
  describe "#destroy" do
    context "with an existing id" do
      before { delete :destroy, id: 1, format: :json }

      it_behaves_like "an success"

      it "render the sandwich" do
        expect(response.body).to include blt_sandwich.name
        expect(response.body).to include blt_sandwich.bread_type
      end
    end

    context "with a non-existing id" do
      before { put :update, id: invalid_id, name: "bacon", format: :json }

      it_behaves_like "an error handler"
    end
  end
end
