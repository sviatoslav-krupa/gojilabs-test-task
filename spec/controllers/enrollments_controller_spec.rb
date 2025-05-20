require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:student_id) { '1' }
  let(:section_id) { '1' }
  let(:enrollment) { double(Enrollment, id: 1, student_id: student_id, section_id: section_id) }
  let(:success_result) { double(ServiceResult, success: true, data: enrollment, errors: nil) }
  let(:failure_result) { double(ServiceResult, success: false, data: nil, errors: { error: 'message' }) }

  describe 'POST #create' do
    context 'with valid parameters' do
      before do
        allow(CreateEnrollmentService).to receive(:new)
                                            .with(student_id, section_id)
                                            .and_return(double(call: success_result))

        post :create, params: { student_id: student_id, section_id: section_id }
      end

      it 'calls CreateEnrollmentService' do
        expect(CreateEnrollmentService).to have_received(:new).with(student_id, section_id)
      end

      it 'returns created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        allow(CreateEnrollmentService).to receive(:new)
                                            .with(student_id, section_id)
                                            .and_return(double(call: failure_result))

        post :create, params: { student_id: student_id, section_id: section_id }
      end

      it 'returns unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors' do
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when enrollment exists' do
      before do
        allow(DeleteEnrollmentService).to receive(:new)
                                            .with(enrollment.id.to_s)
                                            .and_return(double(call: success_result))

        delete :destroy, params: { id: enrollment.id }
      end

      it 'calls DeleteEnrollmentService' do
        expect(DeleteEnrollmentService).to have_received(:new).with(enrollment.id.to_s)
      end

      it 'returns no content status' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when enrollment does not exist' do
      before do
        allow(DeleteEnrollmentService).to receive(:new)
                                            .with(enrollment.id.to_s)
                                            .and_return(double(call: failure_result))

        delete :destroy, params: { id: enrollment.id }
      end

      it 'returns not found status' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns errors' do
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end
  end
end
