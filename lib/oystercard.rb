# creates an Oyster class
class Oystercard
  attr_reader :balance, :entry_station

  MAXV = 90
  MINV = 1

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(value)
    raise 'New balance exceeds #{MAXV}' if balance + value > MAXV
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Bal. < than #{MINV}' if balance < MINV
    @entry_station = entry_station
  end

  def touch_out(fare)
    deduct(fare)
    @entry_station = nil
  end

  def in_journey?
    if @entry_station
      return true
    else
      return false
    end 
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
