class StudentsController < ApplicationController
  def schedule
    student = Student.find(params[:id])

    respond_to do |format|
      format.json { render json: student.sections }
      format.pdf do
        pdf = GenerateSchedulePdf.new(student)
        send_data pdf.render, filename: "schedule.pdf", type: "application/pdf"
      end
    end
  end
end
