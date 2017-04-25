require 'redis'
#require 'logger'


POC = {}
POC[:name] = "redis 未授权访问"
POC[:description] = "redis 默认空密码，可以获取数据库信息甚至控制服务器"
POC[:type] = "未授权访问"
POC[:level] = "高危"
POC[:author] = "Hei@xiu"

class Exploit
	def initialize(options)
		#@logger = Logger.new("redis.log")

		@ip = options[:ip]
	end

	def verify
		begin
			redis = Redis.new(host: @ip, port: 6379)
			redis.select 0
		rescue
		end
		return false unless redis.connected?
		true
	end

	def exploit
		puts "exploit"
	end

end



if __FILE__ == $0
	ip = "192.168.0.1"
	exp = Exploit.new({ip: ip})
	flag, msg = exp.verify
	msg ||= ip
	puts msg if flag
end