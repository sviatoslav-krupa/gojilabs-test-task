require 'rails_helper'

RSpec.describe DeleteEnrollmentService do
  let!(:enrollment) { create(:enrollment, student: student, section: section) }
  let(:student) { create(:student) }
  let(:section) { create(:section) }

  describe '#call' do
    context 'when enrollment exists' do
      it 'deletes the enrollment' do
        expect {
          described_class.new(enrollment.id).call
        }.to change(Enrollment, :count).by(-1)
      end

      it 'returns successful ServiceResult' do
        result = described_class.new(enrollment.id).call
        expect(result).to be_success
        expect(result.errors).to be_nil
      end
    end

    context 'when enrollment does not exist' do
      it 'does not change enrollment count' do
        expect {
          described_class.new(999).call
        }.not_to change(Enrollment, :count)
      end

      it 'returns failed ServiceResult with error message' do
        result = described_class.new(999).call
        expect(result).not_to be_success
        expect(result.errors).to include("Couldn't find Enrollment")
      end
    end

    context 'with invalid parameters' do
      it 'returns failed ServiceResult with error message when id is nil' do
        result = described_class.new(nil).call
        expect(result).not_to be_success
        expect(result.errors).to include("Couldn't find Enrollment without an ID")
      end
    end
  end
end
