require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before{@project=Project.new;render}
  subject{response}

  it{should have_selector "form.simple_form.form-horizontal#new_project"}
  it{should have_selector "input[name='project[name]']"}
  it{should have_selector "input[name='project[number]']"}
  it{should have_selector "select[name='project[group_id]']"}
end
