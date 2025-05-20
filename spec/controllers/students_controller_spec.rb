require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe 'GET #schedule' do
    let(:student) { instance_double(Student, id: 1) }

    before do
      allow(Student).to receive(:find).with('1').and_return(student)
    end

    context 'when format is JSON' do
      let(:sections) { [ double('Section1'), double('Section2') ] }

      before do
        allow(student).to receive(:sections).and_return(sections)
      end

      it 'returns the student sections as JSON' do
        get :schedule, params: { id: '1' }, format: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(response.body).to eq(sections.to_json)
      end
    end

    context 'when format is PDF' do
      let(:pdf_double) { instance_double(GenerateSchedulePdf, render: '%PDF-content%') }

      before do
        allow(GenerateSchedulePdf).to receive(:new).with(student).and_return(pdf_double)
      end

      it 'sends the generated PDF data' do
        get :schedule, params: { id: '1' }, format: :pdf

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq 'application/pdf'
        expect(response.body).to eq('%PDF-content%')
        expect(response.headers['Content-Disposition']).to include('filename="schedule.pdf"')
      end
    end
  end
end
