require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: :controller do 
  describe "GET #new" do 
    subject { get :new }
    it "renders new template" do
      expect(subject).to render_template(:new)
    end
    
    it "renders the proper template" do
      expect(subject).to_not render_template("users/index")
    end
  end
  
  describe "POST #create" do
    context "with invalid params" do
      it "validates presence of password and renders new template with errors" do
        post :create, params: {user: {email: 'Liz', password: ""}}
        expect(response).to render_template(:new)
      end
    end
    context "With valid params" do
      it "logs user in" do 
        post :create, params: {user: {email: 'Liz', password: "123456"}}
        user = User.find_by(email: 'Liz')
        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end
end