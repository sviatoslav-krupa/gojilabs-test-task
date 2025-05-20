
# == Schema Information
#
# Table name: sections
#
#  id               :bigint           not null, primary key
#  duration_minutes :integer          not null
#  start_time       :time             not null
#  weekdays         :string           default([]), is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  classroom_id     :bigint           not null
#  subject_id       :bigint           not null
#  teacher_id       :bigint           not null
#
# Indexes
#
#  index_sections_on_classroom_id  (classroom_id)
#  index_sections_on_subject_id    (subject_id)
#  index_sections_on_teacher_id    (teacher_id)
#

require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'associations' do
    it { should belong_to(:teacher).with_foreign_key("teacher_id").class_name("Teacher") }
    it { should belong_to(:subject) }
    it { should belong_to(:classroom) }
    it { should have_many(:enrollments) }
    it { should have_many(:students).through(:enrollments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:duration_minutes) }
    it { should validate_presence_of(:weekdays) }
    it { should validate_inclusion_of(:duration_minutes).in_array([ 50, 80 ]) }
  end
end
