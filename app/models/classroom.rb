# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Classroom < ApplicationRecord
  validates :code, presence: true, uniqueness: { case_sensitive: false }
end
