require 'station.rb'

describe Station do
station1 = Station.new("Aldgate", 1)

  it 'has a name and a zone on creation' do
    expect(station1).to have_attributes(:name => "Aldgate", :zone => 1)
  end
end
