require 'net/http'

uri = URI('https://github.com/jcolag/entropy-arbitrage/')
imageUrl = ''

Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
  request = Net::HTTP::Get.new uri
  response = http.request request
  imageUrl = response
    .body
    .gsub('<', "\n<")
    .split("\n")
    .filter{|l| l.include? '"og:image"'}[0]
    .split('"')[3]
end

puts imageUrl

