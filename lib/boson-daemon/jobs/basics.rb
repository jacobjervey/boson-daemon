require 'boson-daemon/jobs/base'

module Boson
	module Daemon
		module Jobs
			
			class Ping < Base

				updater :pong

				def execute(data)
					pong
				end

			end

		end
	end
end