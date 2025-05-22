class CreateEnrollmentService
  def initialize(student_id, section_id)
    @student_id = student_id
    @section_id = section_id
  end

  def call
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
end
