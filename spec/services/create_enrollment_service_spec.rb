require 'rails_helper'

RSpec.describe CreateEnrollmentService do
  let(:student) { create(:student) }
  let(:section) { create(:section) }

  describe '#call' do
    context 'with valid parameters' do
      it 'creates a new enrollment' do
        expect {
          described_class.new(student.id, section.id).call
        }.to change(Enrollment, :count).by(1)
      end

      it 'returns successful ServiceResult with enrollment' do
        result = described_class.new(student.id, section.id).call

        expect(result.success?).to be true
        expect(result.data).to be_a(Enrollment)
        expect(result.data.student_id).to eq(student.id)
        expect(result.data.section_id).to eq(section.id)
        expect(result.errors).to be_nil
      end
    end

    context 'with invalid parameters' do
      it 'does not create enrollment when student_id is invalid' do
        expect {
          described_class.new(nil, section.id).call
        }.not_to change(Enrollment, :count)
      end

      it 'returns failed ServiceResult with errors' do
        result = described_class.new(nil, section.id).call

        expect(result.success?).to be false
        expect(result.errors).to be_present
      end
    end

    context 'when record not found' do
      it 'handles non-existent student' do
        result = described_class.new(999, section.id).call
        expect(result.success?).to be false
      end

      it 'handles non-existent section' do
        result = described_class.new(student.id, 999).call
        expect(result.success?).to be false
      end
    end

    context 'with schedule conflict' do
      let!(:existing_enrollment) { create(:enrollment, student: student, section: conflicting_section) }
      let(:conflicting_section) { create(:section, weekdays: [ "monday" ], start_time: '08:00') }
      let(:new_section) { create(:section, weekdays: [ "monday" ], start_time: '08:00') }

      it 'does not create conflicting enrollment' do
        expect {
          described_class.new(student.id, new_section.id).call
        }.not_to change(Enrollment, :count)
      end

      it 'returns validation errors for conflict' do
        result = described_class.new(student.id, new_section.id).call
        expect(result.success?).to be false
      end
    end
  end
end
