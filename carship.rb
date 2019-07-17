require_relative 'car'
require_relative 'spaceship'

class Carship < ::Car
  include Spaceship::Hyperdrive
  include Spaceship::Flight
end