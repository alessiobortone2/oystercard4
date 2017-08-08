# creates an Oyster class
class Oystercard
  attr_reader :balance, :entry_station, :list_of_journeys

  MAXV = 90
  MINV = 1

  def initialize(balance = 0, _list_of_journeys)
    @balance = balance
    @list_of_journeys = []
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
    deduct(fare)
    @entry_station = nil
    @exit_station = exit_station
    journey = { entry_station => exit_station }
    @list_of_journeys << journey
  end

  def in_journey?
    if @entry_station
      true
    else
      false
    end
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
