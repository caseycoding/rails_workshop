require_relative 'spaceship'

class Car
  attr_reader :speed, :state, :power_state

  def initialize
    super
    @state = :park
    @power_state = false
    @seatbelt_fastened = false
    @speed = 0
  end

  def on!
    if @_before_turn_on
      turn_on_check = @_before_turn_on.call
      p 'DOH! Start your engine?' unless turn_on_check
      return unless turn_on_check
    end
    @power_state = true
    @state = :park
  end

  def off!
    @power_state = false
    @state = :off
  end

  def drive!
    if @_before_drive
      drive_check = @_before_drive.call
      p 'DOH! Can\'t put it in drive' unless drive_check
      return unless drive_check
    end
    @state = :drive
  end

  def park!
    if @_before_park
      park_check = @_before_park.call
      p 'DOH! Can\'t put it in park' unless park_check
      return unless park_check
    end
    @state = :park
  end

  def reverse!
    @state = :reverse
  end

  def fasten_seatbelts!
    @seatbelt_fastened = true
  end

  def accelerate!
    @speed += 5 if @power_state
  end

  def decelerate!
    @speed -= 5 if @power_state
  end

  def seatbelt_fastened?
    @seatbelt_fastened
  end

  def before_park(&before_park_block)
    @_before_park = before_park_block
  end

  def before_turn_on(&before_turn_on)
    @_before_turn_on = before_turn_on
  end

  def before_drive(&before_drive)
    @_before_drive = before_drive
  end
end