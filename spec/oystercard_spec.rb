require 'oystercard.rb'

describe Oystercard do
  let(:station) { double :station }
  dv = 0
  loj = nil # list of journeys
  fare = 1
  subject(:Oystercard) { described_class.new(dv, loj) }

  it 'check newly initialized card has a default balance of 0' do
    expect(subject.balance).to eq dv
  end

  it 'adds money to the balance' do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

  it 'fails if new balance greater than limit' do
    expect { subject.top_up(91) }.to raise_error 'New balance exceeds #{MAXV}'
  end

  it 'fails if new balance lower than min' do
    dv = 1
    subject.send(:deduct, fare)
    expect { subject.touch_in(:station) }.to raise_error 'Bal. < than #{MINV}'
  end

  it 'deducts fare from balance' do
    dv = 2
    subject.send(:deduct, dv)
    expect(subject.balance).to eq 0
  end

  it 'can be touched in' do
    subject.touch_in(:station)
    expect(subject.in_journey?).to eq true
  end

  it 'can be touched out' do
    subject.touch_in(:station)
    subject.touch_out(dv, loj)
    expect(subject.in_journey?).to eq false
  end

  it 'can deduct fare on touch out' do
    subject.touch_in(:station)
    expect { subject.touch_out(dv, loj) }.to change { subject.balance }.by(-dv)
  end

  it 'can remember the entry station on touch in' do
    subject.touch_in(:station)
    expect(subject.entry_station).to eq :station
  end

  it 'checks that a new Oystercard has an empty list of journeys' do
    expect(subject.list_of_journeys).to eq []
  end

  it 'checks that touch in/out creates a new journey' do
    subject.touch_in(:station)
    expect(subject.list_of_journeys).not_to be nil
  end

  it 'checks whether to assign penalty_fare' do
    subject.touch_in(:station)
    a = subject.fare
    expect(a).to eq(fare)
  end
end
