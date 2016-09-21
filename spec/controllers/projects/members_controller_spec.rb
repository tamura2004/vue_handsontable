require 'rails_helper'

RSpec.describe Projects::MembersController, type: :controller do

  let(:valid_session) { {project_id:1} }

  describe "GET #index" do
    subject{create :assign}

    it "assigns members/project/assignment" do
      get :index, params: {project_id:1}, session: valid_session
      expect(assigns(:members)).to eq([subject.member])
      expect(assigns(:project)).to eq(subject.project)
      expect(assigns(:assignments)).to eq([subject])
    end
  end

end
