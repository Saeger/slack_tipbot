require 'bitcoin-client'
require './src/bitcoin_client_extensions.rb'
require './src/command.rb'
require 'dotenv/load'
set :bind, '0.0.0.0'

puts ENV['SLACK_API_TOKEN']

raise "Invalid slack token" if ENV['SLACK_API_TOKEN'].nil?

begin
  command = Command.new(params)
  command.perform
rescue Exception => ex
  # error
end
