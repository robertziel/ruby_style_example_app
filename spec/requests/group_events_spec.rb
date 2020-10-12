require 'rails_helper'

describe GroupEventsController do
  describe '#create' do
    subject do
      post group_events_path, params: attributes
      response
    end

    context 'when request attributes are valid' do
      let(:attributes) { { state: GroupEvent::DRAFT } }

      it { expect(subject).to have_http_status(201) }
    end

    context 'when request attributes are not valid' do
      let(:attributes) { { state: GroupEvent::PUBLISHED } }

      it { expect(subject).to have_http_status(422) }
    end
  end

  describe '#update' do
    let(:group_event) { create :group_event, :draft }

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
end
