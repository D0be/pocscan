require 'portscan'

class Portscanasync
	include Sidekiq::Worker

	def save_to_json(hosts, filename)
		File.open(filename, 'w') do |f|
			f.write(hosts.to_json)
		end
	end
	

	def perform(id)
		scan = Port.find(id)
		scan.status = 1
		scan.save
		filename = PortScan.configuration.output_dir + scan.id.to_s
		nmap_opts = PortScan.configuration.nmap_default_opts
		nmap_opts['output_all'] = filename
		nmap_opts['targets'] = scan.target
		portscan = PortScan::Portscan.new
		if nmap_opts['sudo']
			portscan.sudo_scan(nmap_opts)
		else
			portscan.scan(nmap_opts)
		end
		cvesearch = PortScan::CveSearch.new
		result = cvesearch.scan(filename + '.xml')
		save_to_json(result, filename + '.json')
		scan.status = 2
		scan.save
		redis.set id, filename + '.json'
	end

	def redis
		@redis ||= Redis.new
	end
	
end
