require 'journey.rb'

describe Journey do
  subject { Journey.new('aldgate', 'cannon street') }

  it 'should respond to fare' do
    expect(subject).to respond_to(:fare)
  end
end
