# == Schema Information
#
# Table name: job_titles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JobTitle < ApplicationRecord
end
