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
class Enrollment < ApplicationRecord
  belongs_to :student, class_name: "Student", foreign_key: "student_id"
  belongs_to :section
end
