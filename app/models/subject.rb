# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Subject < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
