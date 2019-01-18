require 'journeylog'

describe JourneyLog do
  let(:entry_station) { double 'entry_station' }
  let(:exit_station) { double 'exit_station' }
  let(:journey) { double 'journey' }

  it 'initializes with an empty log' do
    expect(subject.journey_list).to eq []
  end

  describe '#start' do
    it do
      subject.start(entry_station)
      expect(subject.journey_list[-1].current_journey[:in]).to eq entry_station
    end
  end

  describe '#finish' do
    it 'adds exit station to current journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journey_list[-1].current_journey[:out]).to eq exit_station
    end
  end

  describe '#current_journey' do
    it 'should return an incomplete journey' do
      subject.start(entry_station)
      expected_hash = { in: entry_station }
      expect(subject.current_journey).to eq expected_hash
    end

    it 'creates a new journey if returns complete journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journey_list[-1].current_journey.include?(:out)).to eq true
    end
  end

  describe '#journeys' do

    it 'returns a list of journeys' do
      subject.start(entry_station)
      subject.finish(exit_station)
      subject.start(exit_station)
      subject.finish(entry_station)

      expected_list = [ {in: entry_station, out: exit_station}, {in: exit_station, out: entry_station} ]

      expect(subject.journeys).to eq expected_list
    end

  end





end
