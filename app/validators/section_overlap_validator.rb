class SectionOverlapValidator < ActiveModel::Validator
  def validate(record)
    section = record.section
    student = record.student

    return if section.nil? || student.nil?

    if section.students.include?(student)
      record.errors.add(:base, "Student is already enrolled in this section")
      return
    end

    overlapping_sections = student.reload.sections.select do |s|
      time_overlap?(section, s) && days_overlap?(section, s)
    end

    if overlapping_sections.any?
      record.errors.add(:base, "Section can't be added due to schedule conflict with existing sections")
    end
  end

  private

  def time_overlap?(section, other_section)
    section_end = section.start_time + section.duration_minutes.minutes
    other_end = other_section.start_time + other_section.duration_minutes.minutes

    section.start_time < other_end && other_section.start_time < section_end
  end

  def days_overlap?(section, other_section)
    (section.weekdays & other_section.weekdays).any?
  end
end
