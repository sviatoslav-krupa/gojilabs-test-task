class DeleteEnrollmentService
  def initialize(id)
    @id = id
  end

  def call
    enrollment = Enrollment.find(@id)
    enrollment.destroy
    ServiceResult.new(success: true)
  rescue ActiveRecord::RecordNotFound => e
    ServiceResult.new(success: false, errors: e.message)
  end
end
