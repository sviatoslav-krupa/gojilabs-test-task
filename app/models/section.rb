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
class Section < ApplicationRecord
  VALID_WEEKDAYS = %w[monday tuesday wednesday thursday friday saturday sunday]

  belongs_to :teacher, class_name: "Teacher", foreign_key: "teacher_id"
  belongs_to :subject
  belongs_to :classroom
  has_many :enrollments
  has_many :students, through: :enrollments

  validates :start_time, :duration_minutes, :weekdays, presence: true
  validates :duration_minutes, inclusion: { in: [ 50, 80 ] }
  validates :weekdays, inclusion: { in: VALID_WEEKDAYS }
  validate :no_student_schedule_conflicts

  private

  def no_student_schedule_conflicts
    return unless start_time_changed? || duration_minutes_changed? || weekdays_changed?

    students.each do |student|
      conflicting_sections = student.sections.where.not(id: id).select do |section|
        time_overlap?(section) && days_overlap?(section)
      end

      next if conflicting_sections.empty?

      errors.add(:base, "Student #{student.full_name} has schedule conflict with sections: " +
        conflicting_sections.map(&:id).join(', '))
    end
  end

  def time_overlap?(other_section)
    end_time = start_time + duration_minutes.minutes
    other_end_time = other_section.start_time + other_section.duration_minutes.minutes

    start_time < other_end_time && other_section.start_time < end_time
  end

  def days_overlap?(other_section)
    (weekdays & other_section.weekdays).any?
  end
end
