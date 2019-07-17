module Spaceship
  module Hyperdrive
    def calculate_path!(destination)	# Calculate path to destination.
      @destination = destination
      5
    end

    # Go into hyperspace.
    def engage!
      @hyperdrive = true if @destination
      sleep(3)
    end

    # Exit hyperspace and clear path.
    def disengage!
      @hyperdrive = false
    end
  end

  module Flight
    # Increases speed 50 MPH/second until it is > 600 MPH
    def fly!
      return unless @state == :drive

      while @speed < 600
        @speed += 50
        sleep(1) #number of seconds
        @state = :flying if @speed >= 100
      end
    end

    # Decreases speed 30 MPH/second until it is < 70 MPH
    def land!
      while @speed > 70
        @speed -= 30
        sleep(1) #number of seconds
        @state = :drive if @speed <= 100
      end
    end
  end

  module Weapons
    def fire!
      puts 'onguard'
    end
  end
end