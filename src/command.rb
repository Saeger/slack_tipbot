require 'bitcoin-client'
require './src/slack_client.rb'
require './src/bitcoin_client_extensions.rb'
class Command
  attr_accessor :result, :action, :user_name, :icon_emoji
  ACTIONS = %w(deposit tip withdraw balance help)
  def initialize(slack_params)
    slack = SlackClient.new()
    slack.motd 
    @result = {}
  end

  def perform
    if ACTIONS.include?(@action)
      self.send("#{@action}".to_sym)
    else
  end

  def client
    @client ||= Bitcoin::Client.local
  end

  def help

  end

  def balance
    balance = client.getbalance(@user_id)
  end

  def deposit

  end

  def tip
    user = @params.shift

    target_user = $0.1
    set_amount

    tx = client.sendfrom @user_id, user_address(target_user), @amount
  end

  def withdraw
    address = @params.shift
    set_amount
    tx = client.sendfrom @user_id, address, @amount
  end

  def networkinfo
    info = client.getinfo
  end

  private

  def set_amount
    amount = @params.shift
    @amount = amount.to_i
    randomize_amount if (@amount == "random")
    
    raise @coin_config_module::TOO_POOR_TEXT unless available_balance >= @amount + 1
    raise @coin_config_module::NO_PURPOSE_LOWER_BOUND_TEXT if @amount < @coin_config_module::NO_PURPOSE_LOWER_BOUND
  end

  def randomize_amount
    lower = [1, @params.shift.to_i].min
    upper = [@params.shift.to_i, available_balance].max
    @amount = rand(lower..upper)
  end

  def available_balance
     client.getbalance(@user_id)
  end

  def user_address(user_id)
     existing = client.getaddressesbyaccount(user_id)
    if (existing.size > 0)
      @address = existing.first
    else
      @address = client.getnewaddress(user_id)
    end
  end

end
