# == Schema Information
#
# Table name: sections
#
#  id               :bigint           not null, primary key
#  duration_minutes :integer          not null
#  start_time       :time             not null
#  weekdays         :integer          default([]), is an Array
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
class Section < ApplicationRecord
  belongs_to :teacher, class_name: "Teacher", foreign_key: "teacher_id"
  belongs_to :subject
  belongs_to :classroom
  has_many :enrollments
  has_many :students, through: :enrollments

  validates :start_time, :duration_minutes, :weekdays, presence: true
  validates :duration_minutes, inclusion: { in: [ 50, 80 ] }
end
