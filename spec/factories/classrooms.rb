# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :classroom do
    code { "A01" }
  end
end
