require 'rails_helper'

describe GroupEventsController do
  describe '#create' do
    subject do
      post group_events_path, params: attributes
      response
    end

    context 'when request attributes are valid' do
      let(:attributes) { { state: GroupEvent::DRAFT } }

      it 'returns status code 201' do
        expect(subject).to have_http_status(201)
      end
    end

    context 'when request attributes are not valid' do
      let(:attributes) { { state: GroupEvent::PUBLISHED } }

      it 'returns status code 422' do
        expect(subject).to have_http_status(422)
      end
    end
  end
end
