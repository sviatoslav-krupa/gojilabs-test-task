# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Student < User
  has_many :enrollments, foreign_key: "student_id", dependent: :destroy
  has_many :sections, through: :enrollments
end
