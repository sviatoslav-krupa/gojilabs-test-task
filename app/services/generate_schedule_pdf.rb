class GenerateSchedulePdf < Prawn::Document
  def initialize(student)
    super()
    @student = student
    generate_schedule
  end

  def generate_schedule
    text "Schedule for #{@student.full_name}", size: 18
    move_down 20

    @student.sections.each do |section|
      text [
             "Course: #{section.subject.title}",
             "Time: #{section.start_time.strftime('%H:%M')}-#{(section.start_time + section.duration_minutes.minutes).strftime('%H:%M')}",
             "Days: #{section.weekdays.map(&:capitalize).join(", ")}",
             "Room: #{section.classroom.code}",
             "Instructor: #{section.teacher.full_name}"
           ].join(" | ")
      move_down 10
    end
  end
end
