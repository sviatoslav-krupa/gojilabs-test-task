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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:type) }
  end

  describe '#full_name' do
    let(:user) { build(:teacher, first_name: 'John', last_name: 'Doe') }

    it 'returns full name' do
      expect(user.full_name).to eq('John Doe')
    end
  end
end
