
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
    it { should validate_inclusion_of(:duration_minutes).in_array([50, 80]) }

    describe '#no_student_schedule_conflicts' do
      let(:student) { create(:student) }
      let(:section1) do
        create(:section,
               weekdays: ['monday', 'wednesday'],
               start_time: '08:00',
               duration_minutes: 50)
      end

      before { create(:enrollment, student: student, section: section1) }

      context 'when no time conflict' do
        let(:section2) do
          build(:section,
                weekdays: ['monday'],
                start_time: '09:00',
                duration_minutes: 50)
        end

        it 'allows enrollment' do
          section2.students << student
          expect(section2).to be_valid
        end
      end

      context 'when time conflict on same day' do
        let(:section2) do
          build(:section,
                weekdays: ['monday'],
                start_time: '08:30',
                duration_minutes: 50)
        end

        it 'prevents enrollment' do
          section2.students << student
          expect(section2).not_to be_valid
          expect(section2.errors[:base]).to include(/schedule conflict/)
        end
      end

      context 'when time conflict but different days' do
        let(:section2) do
          build(:section,
                weekdays: ['tuesday'],
                start_time: '08:30',
                duration_minutes: 50)
        end

        it 'allows enrollment' do
          section2.students << student
          expect(section2).to be_valid
        end
      end
    end
  end
end
