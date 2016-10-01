require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "GET #index" do
    before{get :index}

    it {expect(response.status).to eq 200}
    it {expect(response).to render_template :index}
    it {expect(assigns(:records)).to be}
    it {expect(assigns(:options)).to be}
  end

  describe "GET #new" do
    before{get :new}

    it {expect(response.status).to eq 200}
    it {expect(response).to render_template :new}
    it {expect(assigns(:project)).to be}
  end
end
