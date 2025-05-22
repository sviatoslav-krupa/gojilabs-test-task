require 'rails_helper'

RSpec.describe SectionOverlapValidator do
  let(:student) { create(:student) }

  let(:section1) do
    create(:section,
           start_time: Time.parse("10:00"),
           duration_minutes: 50,
           weekdays: %w[monday wednesday]
    )
  end

  let(:section2) do
    create(:section,
           start_time: Time.parse("10:30"),
           duration_minutes: 80,
           weekdays: [ "monday" ]
    )
  end

  let(:section3) do
    create(:section,
           start_time: Time.parse("12:00"),
           duration_minutes: 50,
           weekdays: [ "tuesday" ]
    )
  end

  context "when student already enrolled in section" do
    it "is invalid" do
      create(:enrollment, student: student, section: section1)
      enrollment = Enrollment.new(student: student, section: section1)

      expect(enrollment).to be_invalid
      expect(enrollment.errors[:base]).to include("Student is already enrolled in this section")
    end
  end

  context "when sections overlap in time and weekday" do
    it "is invalid" do
      create(:enrollment, student: student, section: section1)
      enrollment = Enrollment.new(student: student, section: section2)

      expect(enrollment).to be_invalid
      expect(enrollment.errors[:base]).to include("Section can't be added due to schedule conflict with existing sections")
    end
  end

  context "when sections do not overlap" do
    it "is valid" do
      create(:enrollment, student: student, section: section1)
      enrollment = Enrollment.new(student: student, section: section3)

      expect(enrollment).to be_valid
    end
  end
end
