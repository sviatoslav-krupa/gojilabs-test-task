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

RSpec.describe Student, type: :model do
  describe 'associations' do
    it { should have_many(:enrollments).with_foreign_key("student_id").dependent(:destroy) }
    it { should have_many(:sections).through(:enrollments) }
  end
end
