# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :subject do
    title { "Mathematics" }
  end
end
