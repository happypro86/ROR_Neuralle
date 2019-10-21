require 'rails_helper'

RSpec.describe Calendar::CalendarRetrieve do
  DATE = Date.today.beginning_of_day.to_i * 1000
  let(:response) do
    {
      'results' => [{
        'time'    => DATE,
        'id'      => 99
      }]
    }
  end

  context 'new event' do
    it 'should extract the time and id' do
      expect(Event).to receive(:create!) do |params|
        expect(params[:time]).to eq Time.at(DATE/1000).to_datetime
        expect(params[:uid]).to eq 99
      end
      described_class.new.parse_response(response, 'ny-tech')
    end
  end

  context 'event exists' do
    before(:each) do
      Event.create(:uid => 99)
    end
    it 'should skip existing events' do
      expect(Event).to_not receive(:create!)
      described_class.new.parse_response(response, 'ny-tech')
    end
  end
end
