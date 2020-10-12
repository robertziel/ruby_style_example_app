require 'rails_helper'

describe GroupEventsController do
  let(:group_event) { create :group_event, :draft }

  describe '#show' do
    subject do
      get group_event_path(group_event)
      response
    end

    it 'returns the todo' do
      subject
      expect(json).not_to be_empty
      expect(json['id']).to eq(group_event.id)
    end

    it 'returns status code 200' do
      expect(subject).to have_http_status(200)
    end
  end

  describe '#create' do
    subject do
      post group_events_path, params: attributes
      response
    end

    context 'when request attributes are valid' do
      let(:attributes) { { state: GroupEvent::DRAFT } }

      it { expect(subject).to have_http_status(201) }

      it 'adds a new group_event' do
        expect { subject }.to change { GroupEvent.count }
      end
    end

    context 'when request attributes are not valid' do
      let(:attributes) { { state: GroupEvent::PUBLISHED } }

      it { expect(subject).to have_http_status(422) }

      it 'does not add a new group_event' do
        expect { subject }.not_to change { GroupEvent.count }
      end
    end
  end

  describe '#update' do
    subject do
      put group_event_path(group_event), params: attributes
      response
    end

    context 'when request attributes are valid' do
      let(:attributes) { { state: GroupEvent::DRAFT } }

      it { expect(subject).to have_http_status(204) }
    end

    context 'when request attributes are not valid' do
      let(:attributes) { { state: GroupEvent::PUBLISHED } }

      it { expect(subject).to have_http_status(422) }
    end
  end

  describe '#destroy' do
    subject do
      delete group_event_path(group_event)
      response
    end

    it { expect(subject).to have_http_status(204) }

    it 'marks group_event as deleted' do
      subject
      expect(group_event.reload.deleted_at).not_to be_nil
    end
  end
end
