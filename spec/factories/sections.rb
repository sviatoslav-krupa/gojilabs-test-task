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
FactoryBot.define do
  factory :section do
    teacher
    subject
    classroom
    start_time { '08:00' }
    duration_minutes { 50 }
    weekdays { Section::VALID_WEEKDAYS.sample(3) }
  end
end
