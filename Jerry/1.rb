data = {}
postdata = "name=asdasd&params=asdasd&method=POST"
postdata.split('&').each do |params|
    puts params
    param = params.split('=')
    data[param[0]] = param[1]
end
puts data