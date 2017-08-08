require 'oystercard.rb'

describe Oystercard do
  let(:station) { double :station }
  dv = 1
  subject(:Oystercard) { described_class.new(dv) }

  it 'check newly initialized card has a default balance of 0' do
    expect(subject.balance).to eq dv
  end

  it 'adds money to the balance' do
    subject.top_up(5)
    expect(subject.balance).to eq 6
  end

  it 'fails if new balance greater than limit' do
    expect { subject.top_up(90) }.to raise_error 'New balance exceeds #{MAXV}'
  end

  it 'fails if new balance lower than min' do
    subject.send(:deduct, dv)
    expect { subject.touch_in(:station) }.to raise_error 'Bal. < than #{MINV}'
  end

  it 'deducts fare from balance' do
    subject.send(:deduct, dv)
    expect(subject.balance).to eq 0
  end
end

describe Oystercard do
  let(:station) { double :station }
  dv = 1
  subject(:Oystercard) { described_class.new(dv) }

  it 'can be touched in' do
    subject.touch_in(:station)
    expect(subject.in_journey?).to eq true
  end

  it 'can be touched out' do
    subject.touch_in(:station)
    subject.touch_out(dv)
    expect(subject.in_journey?).to eq false
  end

  it 'can deduct fare on touch out' do
    subject.touch_in(:station)
    expect { subject.touch_out(dv) }.to change { subject.balance }.by(-dv)
  end

  it 'can remember the entry station on touch in' do
    subject.touch_in(:station)
    expect(subject.entry_station).to eq :station
  end
end
