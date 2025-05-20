# frozen_string_literal: true

# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'validations' do
    subject { build(:classroom) }

    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code).case_insensitive }
  end
end
