class CreateEnrollmentService
  def initialize(student_id, section_id)
    @student_id = student_id
    @section_id = section_id
  end

  def call
    check_sections_overlap

    enrollment = Enrollment.new(student_id: @student_id, section_id: @section_id)

    if enrollment.save
      ServiceResult.new(success: true, data: enrollment)
    else
      ServiceResult.new(success: false, errors: enrollment.errors)
    end
  rescue ActiveRecord::RecordInvalid => e
    ServiceResult.new(success: false, errors: [ "Section can't be added to the student due to schedule conflict." ])
  rescue ActiveRecord::RecordNotFound => e
    ServiceResult.new(success: false, errors: e.message)
  end

  private

  def check_sections_overlap
    section = Section.find(@section_id)
    student = Student.find(@student_id)

    if section.students.include?(student)
      raise ActiveRecord::RecordInvalid
    end

    overlapping_sections = student.sections.select do |s|
      time_overlap?(section, s) && days_overlap?(section, s)
    end

    if overlapping_sections.any?
      raise ActiveRecord::RecordInvalid
    end
  end

  def time_overlap?(section, other_section)
    end_time = section.start_time + section.duration_minutes.minutes
    other_end_time = other_section.start_time + other_section.duration_minutes.minutes

    section.start_time < other_end_time && other_section.start_time < end_time
  end

  def days_overlap?(section, other_section)
    (section.weekdays & other_section.weekdays).any?
  end
end
