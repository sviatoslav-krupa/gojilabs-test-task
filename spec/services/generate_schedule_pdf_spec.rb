require 'rails_helper'
require 'prawn'

RSpec.describe GenerateSchedulePdf do
  let(:student) { create(:student) }
  let(:subject1) { create(:subject, title: 'Mathematics') }
  let(:subject2) { create(:subject, title: 'Physics') }
  let(:teacher1) { create(:teacher, first_name: 'John', last_name: 'Doe') }
  let(:teacher2) { create(:teacher, first_name: 'Jane', last_name: 'Smith') }
  let(:classroom1) { create(:classroom, code: 'A101') }
  let(:classroom2) { create(:classroom, code: 'B202') }

  before do
    section1 = create(:section,
                      subject: subject1,
                      teacher: teacher1,
                      classroom: classroom1,
                      start_time: Time.parse('09:00'),
                      duration_minutes: 50,
                      weekdays: ['monday', 'wednesday']
    )

    section2 = create(:section,
                      subject: subject2,
                      teacher: teacher2,
                      classroom: classroom2,
                      start_time: Time.parse('13:30'),
                      duration_minutes: 80,
                      weekdays: ['tuesday', 'thursday']
    )

    student.sections << [section1, section2]
  end

  describe '#initialize' do
    it 'generates a PDF with student schedule' do
      pdf = GenerateSchedulePdf.new(student)
      text_analysis = PDF::Inspector::Text.analyze(pdf.render)

      expect(text_analysis.strings).to include("Schedule for #{student.full_name}")

      expect(text_analysis.strings.join(' ')).to include(
                                                   "Course: Mathematics | Time: 09:00-09:50 | Days: Monday, Wednesday | Room: A101 | Instructor: John Doe"
                                                 )

      expect(text_analysis.strings.join(' ')).to include(
                                                   "Course: Physics | Time: 13:30-14:50 | Days: Tuesday, Thursday | Room: B202 | Instructor: Jane Smith"
                                                 )
    end
  end

  describe '#generate_schedule' do
    it 'includes all sections for the student' do
      pdf = GenerateSchedulePdf.new(student)
      text_analysis = PDF::Inspector::Text.analyze(pdf.render)

      expect(text_analysis.strings.count { |s| s.start_with?('Course: ') }).to eq(2)
    end

    it 'correctly formats time ranges' do
      pdf = GenerateSchedulePdf.new(student)
      text_analysis = PDF::Inspector::Text.analyze(pdf.render)

      expect(text_analysis.strings.join(' ')).to include('09:00-09:50')
      expect(text_analysis.strings.join(' ')).to include('13:30-14:50')
    end

    it 'correctly capitalizes weekdays' do
      pdf = GenerateSchedulePdf.new(student)
      text_analysis = PDF::Inspector::Text.analyze(pdf.render)

      expect(text_analysis.strings.join(' ')).to include('Monday, Wednesday')
      expect(text_analysis.strings.join(' ')).to include('Tuesday, Thursday')
    end
  end
end
