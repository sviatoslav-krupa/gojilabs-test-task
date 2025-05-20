# frozen_string_literal: true

# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'validations' do
    subject { build(:subject) }

    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end
end
