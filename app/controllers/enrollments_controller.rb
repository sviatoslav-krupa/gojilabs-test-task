class EnrollmentsController < ApplicationController
  def create
    result = CreateEnrollmentService.new(params[:student_id], params[:section_id]).call

    if result.success
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    result = DeleteEnrollmentService.new(params[:id]).call

    if result.success
      head :no_content
    else
      render json: { errors: result.errors }, status: :not_found
    end
  end
end
