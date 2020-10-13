require 'rails_helper'

describe GroupEventsController do
  let(:group_event) { create :group_event, :published, :filled }
  let(:group_event_attributes) do
    attributes_for :group_event, :published, :filled, duration: nil
  end

  let(:service_attributes) do
    { duration: GroupEvent::DURATION_FACTOR * 9 }
  end

  before do
    allow(StartEndDurationService).to receive(:call).and_return(service_attributes)
  end

  describe '#index' do
    subject do
      group_event
      get group_events_path
      response
    end

    it 'returns todos' do
      subject
      expect(json).to eq [group_event.as_json]
    end

    it 'returns status code 200' do
      expect(subject).to have_http_status(200)
    end
  end

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
      post group_events_path, params: group_event_attributes
      response
    end

    it 'calls StartEndDurationService and sets attributes' do
      subject
      expect(GroupEvent.last.duration).to eq service_attributes[:duration]
    end

    context 'when request attributes are valid' do
      it { expect(subject).to have_http_status(201) }

      it 'adds a new group_event' do
        expect { subject }.to change { GroupEvent.count }
      end
    end

    context 'when request attributes are not valid' do
      before do
        group_event_attributes[:name] = nil
      end

      it { expect(subject).to have_http_status(422) }

      it 'does not add a new group_event' do
        expect { subject }.not_to change { GroupEvent.count }
      end
    end
  end

  describe '#update' do
    subject do
      put group_event_path(group_event), params: group_event_attributes
      response
    end

    context 'when request attributes are valid' do
      it { expect(subject).to have_http_status(204) }
    end

    context 'when request attributes are not valid' do
      before do
        group_event_attributes[:name] = nil
      end

      it { expect(subject).to have_http_status(422) }
    end

    it 'calls StartEndDurationService and sets attributes' do
      subject
      expect(group_event.reload.duration).to eq service_attributes[:duration]
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
