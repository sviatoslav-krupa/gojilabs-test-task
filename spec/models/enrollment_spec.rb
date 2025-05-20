
# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :bigint           not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_enrollments_on_section_id  (section_id)
#  index_enrollments_on_student_id  (student_id)
#

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'associations' do
    it { should belong_to(:student).with_foreign_key("student_id").class_name("User") }
    it { should belong_to(:section) }
  end
end
