class Group < ApplicationRecord
  belongs_to :department
  attr_accessor :department
end
