# frozen_string_literal: true

require './car'

RSpec.describe Car do
  subject { car }
  let(:car) { Car.new }

  let(:get_going) do
    car.on!
    car.fasten_seatbelts!
    car.drive!
    car.accelerate!
  end

  describe 'methods' do
    it 'sets the power state to on when turned on' do
      car.on!
      expect(car.power_state).to be_truthy
    end

    it 'sets the power state to off when turned off' do
      car.off!
      expect(car.power_state).to be_falsy
    end

    it 'sets the transmission state to drive when put in drive' do
      car.drive!
      expect(car.state).to be :drive
    end

    it 'sets the transmission state to park when put in park ' do
      car.park!
      expect(car.state).to be :park
    end

    it 'sets the transmission state to reverse when put in reverse on' do
      car.reverse!
      expect(car.state).to be :reverse
    end

    it 'puts on seatbelts when asked' do
      car.fasten_seatbelts!
      is_expected.to be_seatbelt_fastened
    end

    context 'speed!' do
      before { get_going }

      it 'it increases the speed by five when accelerating' do
        expect(car.speed).to be 5
        car.accelerate!
        expect(car.speed).to be 10
      end

      it 'it decreases the speed by five when decelerating' do
        car.decelerate!
        expect(car.speed).to be 0
      end
    end
  end

  describe 'transmission state' do
    context 'park' do
      it 'defaults to the park state' do
        expect(car.state).to be :park
      end
    end
  end

  describe 'speed' do
    it 'defaults to the speed to zero' do
      expect(car.speed).to be_zero
    end
  end

  describe 'power state' do
    it 'defaults to the power state to off' do
      expect(car.power_state).to be false
    end
  end

  describe 'seatbelt fastened' do
    it 'expected not to the seatbelt state to off' do
      is_expected.not_to be_seatbelt_fastened
    end
  end

  describe 'optional checks' do
    context 'before park' do
      before { get_going }

      it 'does not let you park a moving car' do
        car.before_park { car.speed.zero? && car.state != :off }
        car.park!
        expect(car.state).to be :drive
      end
    end

    context 'before drive' do
      it 'does not let put the car in drive without wearing a seatbelt' do
        car.before_drive { car.seatbelt_fastened? }
        car.drive!
        expect(car.state).to be :park
      end
    end

    context 'before turn on' do
      before { get_going }

      it 'can not turn on a driving car' do
        car.before_turn_on { car.state == :park }
        car.on!
        expect(car.state).to be :drive
      end
    end
  end
end
