require 'webrick'
include WEBrick

puts 'Starting server on port 2000...'
s = HTTPServer.new(:Port => 2000, :DocumentRoot => 'www', :BindAddress => '127.0.0.1')

trap('INT') { s.shutdown }
s.start
