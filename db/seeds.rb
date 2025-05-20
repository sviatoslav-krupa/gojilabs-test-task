# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding database..."

SUBJECT_TITLES = [
  'Introduction to Programming',
  'Linear Algebra',
  'General Physics',
  'General Chemistry',
  'Biology Fundamentals'
]

CLASSROOM_CODES = %w[A101 A102 A103 A104 A105 B101 B102 B103 B104 B105 C101 C102 C103 C104 C105]

TIME_SLOTS = [
  { start_time: '08:00', days: Section::VALID_WEEKDAYS.sample(2) },
  { start_time: '09:00', days: Section::VALID_WEEKDAYS.sample(2) },
  { start_time: '10:00', days: Section::VALID_WEEKDAYS.sample(2) },
  { start_time: '13:00', days: Section::VALID_WEEKDAYS.sample(2) },
  { start_time: '14:00', days: Section::VALID_WEEKDAYS.sample(2) }
]

teachers = 5.times.map do
  Teacher.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

students = 20.times.map do
  Student.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

subjects = SUBJECT_TITLES.map { |title| Subject.create!(title: title) }

classrooms = CLASSROOM_CODES.map { |code| Classroom.create!(code: code) }

sections = TIME_SLOTS.map do |slot|
  Section.create!(
    subject: subjects.sample,
    teacher: teachers.sample,
    classroom: classrooms.sample,
    duration_minutes: [50, 80].sample,
    start_time: slot[:start_time],
    weekdays: slot[:days]
  )
end

students.each do |student|
  sections.sample(rand(3..5)).each do |section|
    Enrollment.create!(student: student, section: section)
  rescue ActiveRecord::RecordInvalid
    next
  end
end

puts "Seeded #{Teacher.count} teachers, #{Subject.count} subjects, #{Classroom.count} classrooms,"
puts "#{Student.count} students, #{Section.count} sections, and #{Enrollment.count} enrollments."
