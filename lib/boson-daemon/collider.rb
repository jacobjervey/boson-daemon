# Boson 'Collider', handles communication between Boson and client nodes

require "json"
require "net/http"
require "uri"
require "pubnub"

# Do this automatically
require "boson-daemon/jobs/basics"

module Boson
	module Daemon
		class Collider

			def read_job
				@pubnub.subscribe({
					'channel' => "collider-#{@secret_key}",
					'callback' => lambda do |data|
						handle_job(data)
					end
					})
			end

			def update_job(update_type, job_id, data)
				req = Net::HTTP::Post.new("/collider/job_update.json?secret=#{@secret_key}")
				unless data.nil?
					req.set_form_data("type" => update_type, "job" => job_id, "data" => data.to_json)
				else
					req.set_form_data("type" => update_type, "job" => job_id)
				end
				@http.request(req).body
			end

			def load_pubnub_config
				get "/collider.json?secret=#{@secret_key}"
			end

			def initialize
  			@host = URI.parse((ENV['BOSON_URL'] or 'boson.herokuapp.com'))
  			@secret_key = ENV['BOSON_SECRET_KEY']
  			@http = Net::HTTP.new(@host.host, @host.port)

  			config = load_pubnub_config
  			@pubnub = Pubnub.new("", config["subscribe_key"], config["secret_key"], "", false)
  		end

  		protected

  		def handle_job(data)
  			job_type = data['type']
  			job_id = data['id']
  			if Boson::Daemon::Jobs.const_defined?(job_type)
  				job_class = Boson::Daemon::Jobs.const_get(job_type)
  				job = job_class.new(self, job_id)
  				job.execute(data['data'])
  			end
  		end

  		def get(url)
  			# TODO: Handling when the response is not valid
  			JSON.parse(@http.request(Net::HTTP::Get.new(url)).body)
  		end

		end
	end
end