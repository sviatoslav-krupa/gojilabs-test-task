# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe 'associations' do
    it { should have_many(:sections).with_foreign_key("teacher_id").dependent(:destroy) }
  end
end
