# == Schema Information
#
# Table name: systems
#
#  id         :integer          not null, primary key
#  number     :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe System, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
