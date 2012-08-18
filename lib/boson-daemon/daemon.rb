require 'boson-daemon/collider'

module Boson
  module Daemon

    def initialize
    	@collider = Boson::Daemon::Collider.new
    end

  end
end