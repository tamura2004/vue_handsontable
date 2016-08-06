class Department < ApplicationRecord
  validates :name, uniqueness: true, presense: true
end
