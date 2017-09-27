require 'bitcoin-client'
require './src/bitcoin_client_extensions.rb'
require './src/command.rb'
require 'dotenv/load'

begin
  command = Command.new(params)
  command.perform
rescue Exception => ex
  # error
end
