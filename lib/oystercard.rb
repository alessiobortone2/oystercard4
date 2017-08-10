# creates an Oyster class

require './journeylog.rb'
require '.journey.rb'

MAXV = 90
MINV = 1
MINF = 1
PENF = 6

class Oystercard
  attr_reader :balance, :entry_station, :list_journeys

  def initialize(balance = 0, list_journeys = nil)
    @balance = balance
    @list_journeys = []
    @journey = Journey.new
  end

  def top_up(value)
    raise 'New balance exceeds #{MAXV}' if balance + value > MAXV
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Bal. < than #{MINV}' if balance <= MINV
    @entry_station = entry_station
  end

  def touch_out(fare, exit_station)
    @exit_station = exit_station
    deduct(fare)
    @list_journeys << { en: @journey.entry_station, ex: @journey.exit_station }
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  def fare
    return PENF if !@entry_station | !@exit_station
    MINF
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
