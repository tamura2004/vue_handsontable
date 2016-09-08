class WhereareyouController < ApplicationController
  def index
    gon.members = Member.all
  end
end
