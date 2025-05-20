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
FactoryBot.define do
  factory :teacher do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    type { "Teacher" }
  end
end
