require 'net/http'
require 'json'


json = File.read('test.json')

pocjson = JSON.parse(json)



plugin = pocjson["plugin"]
#puts plugin

if plugin["method"] == 'GET'
    begin
        puts plugin["method"]
        uri  = URI.parse "http://thehammeredlamb.com"+plugin["getdata"]
        puts uri
        response = Net::HTTP.get uri
        puts response
    rescue
    end
    puts 'aa' if response.to_s.include? plugin["keyword"]
end

