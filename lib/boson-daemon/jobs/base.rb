module Boson
	module Daemon
		module Jobs
			class Base

				attr_accessor :collider, :job_id

				def self.updater(*names)
					names.each do |name|
						define_method name do |data=nil|
							self.collider.update_job(name, self.job_id, data)
						end
					end
				end

				def execute(data)

				end

				def initialize(collider, job_id)
					@collider = collider
					@job_id = job_id
				end

			end
		end
	end
end